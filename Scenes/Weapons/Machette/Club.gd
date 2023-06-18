extends Weapon

@onready var animation := $ShootingAnimator
var can_shoot := true

func _on_shooting(weapon,target):
	if(self == weapon):
		var shooter_pos = get_parent().global_position
		if(target is Vector2):
			#Machette only works for enemies as of now
			pass
		else:
			if target.global_position.distance_to(shooter_pos) < 90:
				can_shoot = false
				animation.play("shoot")
				if(animation.is_playing()):
					target.hp -= 5
		

func _on_machette_cooldown_timeout():
	can_shoot = true
