extends "res://src/Actors/Actor.gd"


func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	
export var score: = 100

#This kills the enemy when the player jumps on it
func _on_StompDetector_body_entered(body:PhysicsBody2D) -> void:
	if body.global_position.y < get_node("StompDetector").global_position.y:

		get_node("CollisionShape2D").disabled = true
		queue_free()		
		
		
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity,
	FLOOR_NORMAL).y
#This is the code that actually kills the enemy and also adds to the score
func die() -> void:
	queue_free()
	PlayerData.score +=score
