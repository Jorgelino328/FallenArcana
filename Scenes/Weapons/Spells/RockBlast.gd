extends Projectile
var id = 2

func _on_body_entered(body):
	if "id" not in body:
		direction = Vector2.ZERO
		animation.play("end_shot")
