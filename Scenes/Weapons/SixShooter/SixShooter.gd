extends Weapon

@onready var animation := $ShootingAnimator
var can_shoot := true
var bullet = preload("res://Scenes/Weapons/Projectiles/Bullet.tscn")

func _on_shooting(weapon,target):
	if(self == weapon):
		animation.play("shoot")
		$PistolShot.play()
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = $GunEnd.global_position
		var shooter_pos = get_parent().global_position
		if(target is Vector2):
			if target.distance_to(shooter_pos) > 60:
				var direction_of_mouse= bullet_instance.global_position.direction_to(target).normalized()
				bullet_instance.set_direction(direction_of_mouse)
				bullet_instance.dmg_enemies = true
				weapon.get_tree().get_root().add_child(bullet_instance)
		else:
			if target.global_position.distance_to(shooter_pos) > 60:
				var direction_of_mouse= bullet_instance.global_position.direction_to(target).normalized()
				bullet_instance.set_direction(direction_of_mouse)
				weapon.get_tree().get_root().add_child(bullet_instance)
		can_shoot = false
		
func _on_gun_cooldown_timeout():
	can_shoot = true
