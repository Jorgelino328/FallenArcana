extends Projectile
var id = 1

func _on_body_entered(body):
	direction = Vector2.ZERO
	animation.play("end_shot")
