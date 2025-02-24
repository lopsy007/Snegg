extends Node3D


var score = 0

var scene_path_to_load

signal score_changed(score)

@onready var quit_button: Button = %QuitButton
@onready var ground: GridMap = %Ground
@onready var player_object: CharacterBody3D = %Player

@onready var player = Global.player



func _ready() -> void:
	quit_button.connect("pressed", _on_Button_pressed.bind(quit_button.scene_to_load))



func _on_player_died(player_num) -> void:
	if score > player.get_high_score(player_num):
		player.set_high_score(player_num, score)
	call_deferred("_reload_scene")
	
	
func _reload_scene() -> void:
	#save new max
	get_tree().reload_current_scene()


func _on_Button_pressed(scene_to_load) -> void:
	scene_path_to_load = scene_to_load
	$UISound.play()
	
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_fade_in_fade_finished() -> void:
	if score > player.get_high_score(player_object.player_num):
		player.set_high_score(player_object.player_num, score)
	get_tree().change_scene_to_file(scene_path_to_load)


func _on_player_new_max_reached(new_max: float) -> void:
	score = ceil( (int(new_max)+ground.cell_size.z/2) / ground.cell_size.z)
	score_changed.emit(score)
