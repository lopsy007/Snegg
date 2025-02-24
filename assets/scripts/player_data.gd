class_name Player_data
extends Node

static var players: Dictionary = {}
const PATH = "save_data.txt"

var player_name: String

var _high_scores: Dictionary = {1:0, 2:0}


func _init(player_id: String, high_score_1: int = 0, high_score_2: int = 0) -> void:
	player_name = player_id
	players[player_name] = self
	_high_scores[player_name] = {1:high_score_1, 2:high_score_2}
	save()
	

func get_high_score(player_num: int) -> int:
	assert(player_num in _high_scores.keys(), "player_data.gd/get_high_score(player_num) -> player_num is not valid")
	return _high_scores[player_num]
	
func set_high_score(player_num: int, high_score: int) -> void:
	assert(player_num in _high_scores.keys(), "global.gd/Player.set_high_score(player_num) -> player_num is not valid")
	_high_scores[player_num] = high_score
	
	save()


func delete() -> void:
	players.erase(player_name)
	save()
#--------------------------
static func save():
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	
	'''
	{
	"Eirik": {
		h1: x
		h2: y
	}
	"Dana": {
		h1: x
		h2: y
	}
	}
	'''
	
	
	var content: Dictionary = {}
	for p in players.keys():
		content[p] = {"h1":players[p].get_high_score(1), "h2":players[p].get_high_score(2)}

	print(content, "player_data.gd/save")
	
	file.store_var(content)
	file.close()

static func load():
	var file = FileAccess.open(PATH,FileAccess.READ)
	var content = file.get_var()
	
	
	print(content, "player_data.gd/load")
	if content:
		for id in content.keys():
			players[id] = Player_data.new(id, content[id]["h1"], content[id]["h2"])
	else:
		players["Player 1"] = Player_data.new("Player 1", 0, 0)
		print("No players found. Created Player 1 in player_data.gd")
			
