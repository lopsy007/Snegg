extends RichTextLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Score: 0"

func _on_game_score_changed(score: Variant) -> void:
	text = "Score: " + str(score)
