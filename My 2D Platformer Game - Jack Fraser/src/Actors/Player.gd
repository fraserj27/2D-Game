extends Actor


export var stomp_impulse: = 1000.00

#This detects if the player has hit the top of the enemy if it does then it tells the game
func _on_EnemyDetector_area_entered(area: Area2D) -> void:
 velocity = calculate_stomp_velocity(velocity, stomp_impulse)	
	
#This detects if the player hits the side of the enemy if it does then it tells the game
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()
	

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	


func get_direction() ->	 Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted: 
		out.y = 0.0	
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

#This kills the player when the game registers it has died
func die() -> void:
	PlayerData.deaths += 1
	queue_free()
