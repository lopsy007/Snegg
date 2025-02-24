extends Node

@onready var songs = Global.get_paths("assets/music")

func _ready() -> void:
	play_music(songs.pick_random())

func play_music(path):
	$"/root/MusicPlayer".stream = load(path)
	$"/root/MusicPlayer".play()
	
func stop_music():
	$"/root/MusicPlayer".stop()
	


func _on_finished() -> void:
	play_music(songs.pick_random())
	pass # Replace with function body.
