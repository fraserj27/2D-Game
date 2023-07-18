tool
extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

#This teleports the player to the next scene when it enters the portal
func _on_body_entered(body: PhysicsBody2D) -> void:
	teleport()
	
#This tells us if there is no next scene for the player to teleport to
func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
	
#This does the fade in effect when the player teleports to the next level
func teleport() -> void:
		anim_player.play("fade_in")
		yield(anim_player, "animation_finished")
		get_tree().change_scene_to(next_scene)
