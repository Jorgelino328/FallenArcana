extends Area2D
@export var player : CharacterBody2D

func _on_body_entered(body):
	if body == player:
		player.hp += 10
		$PickedUp.play()
		queue_free()
		
