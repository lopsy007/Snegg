extends Node3D

@onready var player: CharacterBody3D = %Player

@onready var ground: GridMap = %Ground
@onready var collidables: GridMap = %Collidables
@onready var deco: GridMap = %Deco
@onready var auto_lane_deletion: Timer = %AutoLaneDeletion


const LANES_PER_JUMP = 2

const LANE_WIDTH = 40
const PLAY_WIDTH = 16
const LANE_OFFSET_X = LANE_WIDTH/2
const START_X = -LANE_WIDTH+LANE_OFFSET_X

const INITIAL_LANE_COUNT = 40
const INITIAL_LANES_OFFSET = 10



var current_z: int = INITIAL_LANES_OFFSET


var road_chance = 0.5



var rng = RandomNumberGenerator.new()
# rng.randomize() every time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_forward(INITIAL_LANE_COUNT)
	for z in range(-1, 2):
		place_lane(collidables, START_X, -START_X, z, -1)
	
	
	


func _on_auto_lane_deletion_timeout() -> void:
	move_forward(1)
	
	

func _on_player_jumped() -> void:
	move_forward(2)
	
	
		
		
func move_forward(lane_count := 1) -> void:
	for i in range(lane_count):
		place_random_ground(START_X, -START_X, current_z)
		#remove first lane
		
		delete_lane(START_X, -START_X, current_z+INITIAL_LANE_COUNT)
		current_z -= 1
	
	
	
func place_random_ground(start_x: int, end_x: int, z: int) -> void:
	rng.randomize()
	var is_road = rng.randf() < road_chance
	if is_road:
		place_road(start_x, end_x, z)
		road_chance = 0.2
	elif not is_road:
		place_grass(start_x, end_x, z)
		road_chance = 0.8
	

	
	
func place_road(start_x: int, end_x: int, z: int, delete := false) -> void:
	if delete:
		place_lane(ground, start_x, end_x, z, -1)
		return
	#place road lane
	
	place_lane(ground, start_x, end_x, z, 0, 22)
	
	#init cars
	
	
func place_grass(start_x: int, end_x: int, z: int, delete := false) -> void:
	if delete:
		place_lane(ground, start_x, end_x, z, -1)
		place_deco(start_x, end_x, z, true)
		place_coll(start_x, end_x, z, true)
		return
	
	place_lane(ground, start_x, end_x, z, 2)
	place_deco(start_x, end_x, z)
	place_coll(start_x, end_x, z)
	
	
	
	
	
func place_deco(start_x: int, end_x: int, z: int, delete := false) -> void:
	if delete:
		place_lane(deco, start_x*2, end_x*2+1, z*2, -1)
		place_lane(deco, start_x*2, end_x*2+1, z*2+1, -1)
		return
		
	
	for current_z in range(z*2, z*2+2):
		for current_x in range(start_x*2, end_x*2+2):
			rng.randomize()
			if rng.randf() < 0.5:
				deco.set_cell_item(Vector3(current_x, 0, current_z), 
				rng.randi_range(0, len(deco.mesh_library.get_item_list())))





func place_coll(start_x: int, end_x: int, z: int, delete := false) -> void:
	if delete:
		place_lane(collidables, start_x, end_x, z, -1)
		return
		
	for current_x in range(start_x, end_x+1):
		rng.randomize()
		
		if rng.randf() < 0.25 or current_x<-PLAY_WIDTH/2 or current_x>PLAY_WIDTH/2:
			collidables.set_cell_item(Vector3(current_x, 0, z),
			rng.randi_range(0, len(collidables.mesh_library.get_item_list())-1))
	
	
	
	
func place_lane(grid_map: GridMap, start_x: int, end_x: int, z: int, 
tile: int, orientation := 0) -> void:
	for current_x in range(start_x, end_x+1):
		grid_map.set_cell_item(Vector3(current_x, 0, z), tile, orientation)	
	
func delete_lane(start_x: int, end_x: int, z: int):
		place_lane(ground, start_x, end_x, z, -1)
		place_deco(start_x, end_x, z, true)
		place_coll(start_x, end_x, z, true)
