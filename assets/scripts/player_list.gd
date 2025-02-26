extends VBoxContainer

@onready var players = Global.players
@onready var deleteButtonScene = preload("res://assets/scenes/Leaderboard/DeletePlayerButton.tscn")
var deleteButton: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_player_list()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered(player_label:RichTextLabel) -> void:
	deleteButton.move_button_to(player_label)
	
	
func update_player_list() -> void:
	delete_player_list()
	# Wait for all player labels to be deleted before creating the next tree.
	# REQUIRED for DeletePlayerButton to function correctly
	# Will crash if removed
	await get_children()[len(get_children())-1].tree_exited
	create_player_list()
	
func create_player_list() -> void:
	
	
	var player_label: RichTextLabel
	for pl in players:
		player_label = RichTextLabel.new()
		player_label.text = pl
		player_label.custom_minimum_size = Vector2(0, 20)
		player_label.scroll_active = false
		add_child(player_label)
		player_label.mouse_entered.connect(_on_mouse_entered.bind(player_label))
	
	deleteButton = deleteButtonScene.instantiate()
	get_children()[0].add_child(deleteButton)
	
	
func delete_player_list() -> void:
	for child in get_children():
		child.queue_free()
