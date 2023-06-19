extends Area2D
@export var player : CharacterBody2D

func _on_body_entered(body):
	if body == player:
		player.get_parent().rock.known_spell = true
		player.knownsRock = true
		$PickedUp.play()
		queue_free()
		
