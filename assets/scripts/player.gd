extends CharacterBody3D



const SPEED = 4
const JUMP_VELOCITY = 4

var player_num = 1

@onready var min_z = position.z

signal jumped
signal died(player_num)
signal new_max_reached(max)





func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		jumped.emit()

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if position.z < min_z:
		min_z = position.z
		new_max_reached.emit(-min_z)
		
		


func _on_killzone_body_entered(_body: Node3D) -> void:
	died.emit(player_num)
	
	
