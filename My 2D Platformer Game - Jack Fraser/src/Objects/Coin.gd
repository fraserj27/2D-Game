extends Area2D

#This is the value that the coin adds to the score when picked up
export var score: = 100

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
#This adds to the score when the player touches the coin and also makes the coin dissappear when touched
func _on_body_entered(body: PhysicsBody2D) -> void:
	PlayerData.score += score
	anim_player.play("fade_out")
	

