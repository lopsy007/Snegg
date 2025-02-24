extends Control

var scene_path_to_load
@onready var background: Sprite2D = $background


func _ready():
	set_process(true)
	$"Menu/CenterRow/Buttons/Start Game".grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", _on_Button_pressed.bind(button.scene_to_load))
		
	
	


func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$UISound.play()
	
	$FadeIn.show()
	$FadeIn.fade_in()
	





func _process(_delta):
	if Input.is_action_pressed("key_exit"):
		$UISound.play()
		get_tree().quit()


func _on_fade_in_fade_finished() -> void:
	get_tree().change_scene_to_file(scene_path_to_load)
	
