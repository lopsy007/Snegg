extends VBoxContainer

@onready var players = Global.players
@onready var deleteButton = preload("res://assets/scenes/Leaderboard/DeletePlayerButton.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_list()
	get_children()[0].add_child(deleteButton)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered(player_label:RichTextLabel) -> void:
	deleteButton.move_button_to(player_label)
	
func _on_mouse_exited() -> void:
	print("exited (player_list.gd)")
	
	
func update_player_list():
	for child in get_children():
		child.queue_free()
	var player_label: RichTextLabel
	for pl in players:
		player_label = RichTextLabel.new()
		player_label.text = pl
		player_label.custom_minimum_size = Vector2(0, 20)
		player_label.scroll_active = false
		add_child(player_label)
		player_label.mouse_entered.connect(_on_mouse_entered.bind(player_label))
