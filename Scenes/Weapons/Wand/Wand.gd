extends Weapon

@export var pelletCount : int
@export var spread : float
@onready var animation := $ShootingAnimator
var can_shoot := true

func _on_shooting(spell,target):
	
	var player_pos = get_parent().global_position
	var spell_instance = spell.instantiate()
	
	if(spell_instance.name == "FireBolt" && can_shoot):
		animation.play("shoot")
		$WandShot.play()
		spell_instance.global_position = $WandEnd.global_position
		if target.distance_to(player_pos) > 60:
			var direction_of_mouse = spell_instance.global_position.direction_to(target).normalized()
			spell_instance.set_direction(direction_of_mouse)
			spell_instance.dmg_enemies = true
			get_tree().get_root().add_child(spell_instance)
			spell_instance.rotation = global_rotation + deg_to_rad(90)
	elif(spell_instance.name == "RockBlast" && can_shoot):
		animation.play("shoot")
		#$WandShot.play()
		for i in range(pelletCount):
			spell_instance = spell.instantiate()
			spell_instance.global_position = $WandEnd.global_position
			var shooter_pos = get_parent().global_position
			var direction_of_mouse = spell_instance.global_position.direction_to(target).normalized()
			var min_x = direction_of_mouse.x - spread
			var min_y = direction_of_mouse.y - spread
			var max_x = direction_of_mouse.x + spread
			var max_y = direction_of_mouse.y + spread
			if target.distance_to(player_pos) > 60:
				direction_of_mouse = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
				spell_instance.set_direction(direction_of_mouse)
				spell_instance.dmg_enemies = true
				get_tree().get_root().add_child(spell_instance)
				spell_instance.rotation = global_rotation + deg_to_rad(90)
	can_shoot = false
	


func _on_gun_cooldown_timeout():
		can_shoot = true

