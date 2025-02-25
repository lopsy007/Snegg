extends Node


var player: Player_data
var players: Dictionary
var songs: Array[String]
var song_to_play: String


func _ready() -> void:
	Player_data.load()
	players = Player_data.players
	player = players.values()[0]
	



func get_paths(dir_path):
	var files: Array[String]
	var dir = DirAccess.open(dir_path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "" :
			if not dir.current_is_dir() and not file_name.ends_with(".import"):
				files.append(dir.get_current_dir()+"/"+file_name)
				
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path", dir_path, "in global.gd/get_paths")
	return files
