extends Projectile
var id = 1

func _on_body_entered(body):
	if body.get_parent().name != "Tulius_Spellbreaker":
		direction = Vector2.ZERO
		animation.play("end_shot")
