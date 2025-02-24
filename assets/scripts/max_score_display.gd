extends RichTextLabel





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Vente litt sånn at global laster inn først
	#await get_tree().create_timer(0.01).timeout
	text = "High score: " + str(Global.player.get_high_score(1))


	
