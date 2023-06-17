extends Weapon

@export var pelletCount : int
@export var spread : float
@onready var animation := $ShootingAnimator
var can_shoot := true
var pellet = preload("res://Scenes/Weapons/Projectiles/Pellet.tscn")

func _on_shooting(weapon,target):
	if(self == weapon):
		animation.play("shoot")
		$ShotgunShot.play()
		$Reload.play()
		for i in range(pelletCount):
			var pellet_instance = pellet.instantiate()
			pellet_instance.global_position = $GunEnd.global_position
			var shooter_pos = get_parent().global_position
			var direction_of_mouse = pellet_instance.global_position.direction_to(target).normalized()
			var min_x = direction_of_mouse.x - spread
			var min_y = direction_of_mouse.y - spread
			var max_x = direction_of_mouse.x + spread
			var max_y = direction_of_mouse.y + spread

			if(target is Vector2):
				if target.distance_to(shooter_pos) > 60:
					direction_of_mouse = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
					pellet_instance.set_direction(direction_of_mouse)
					pellet_instance.dmg_enemies = true
					weapon.get_tree().get_root().add_child(pellet_instance)	
			else:
				if target.global_position.distance_to(shooter_pos) > 60:
					direction_of_mouse = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
					pellet_instance.set_direction(direction_of_mouse)
					weapon.get_tree().get_root().add_child(pellet_instance)	
			can_shoot = false

func _on_gun_cooldown_timeout():
		can_shoot = true
