class_name DeletePlayerDataButton
extends VBoxContainer

@onready var players = Global.players
@onready var deleteButtonScene = preload("res://assets/scenes/Leaderboard/DeletePlayerButton.tscn")
var label_children: Array
var deleteButton: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_list()





func _on_mouse_entered(deleteButton:TextureButton) -> void:
	deleteButton.disabled = false
	
	
func _on_mouse_exited(deleteButton:TextureButton) -> void:
	deleteButton.disabled = true


func update_player_list() -> void:
	for child in get_children():
		child.queue_free()
	
	var player_label: RichTextLabel
	for pl in players:
		player_label = RichTextLabel.new()
		player_label.text = pl
		player_label.custom_minimum_size = Vector2(0, 20)
		player_label.scroll_active = false
		
		
		deleteButton = deleteButtonScene.instantiate()
		player_label.mouse_entered.connect(_on_mouse_entered.bind(deleteButton))
		player_label.mouse_exited.connect(_on_mouse_exited.bind(deleteButton))
		deleteButton.mouse_entered.connect(_on_mouse_entered.bind(deleteButton))
		deleteButton.mouse_exited.connect(_on_mouse_exited.bind(deleteButton))
		deleteButton.disabled = true
		
		player_label.add_child(deleteButton)
		add_child(player_label)

	
