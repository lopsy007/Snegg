extends TextEdit

signal player_list_updated



func _on_confirm_button_pressed() -> void:
	if text.strip_edges() != "": 
		Player_data.new(text.strip_edges())
	player_list_updated.emit()
	print("players")
	print(Global.players)
	text = ""



func _on_reset_button_pressed() -> void:
	text = ""
