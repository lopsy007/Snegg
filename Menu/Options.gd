extends Control

var quit_button: Button

func _ready():
	set_process(true)
	quit_button = $"VBoxContainer/Button"
	quit_button.grab_focus()
	

func _on_Button_pressed():
	$UISound.play()
	
	$FadeIn.show()
	$FadeIn.fade_in()
	

func _on_CheckBox_pressed():
	$UISound.play()
	match DisplayServer.window_get_mode():
		DisplayServer.WindowMode.WINDOW_MODE_WINDOWED: 
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN: 
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)



func _on_FadeIn_fade_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://Menu/Main Menu.tscn")





func _on_Music_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)

func _on_Game_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
