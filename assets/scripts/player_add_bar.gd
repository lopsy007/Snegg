extends TextEdit

signal player_list_updated



func _on_confirm_button_pressed() -> void:
	if text.strip_edges() != "" and text.strip_edges() not in Global.players.keys(): 
		Player_data.new(text.strip_edges())
	player_list_updated.emit()
	text = ""



func _on_reset_button_pressed() -> void:
	text = ""
