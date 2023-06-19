extends Weapon

@onready var animation := $ShootingAnimator
var can_shoot := true
var blast = preload("res://Scenes/Weapons/Spells/FireBolt.tscn")

func _on_shooting(weapon,target):
	animation.play("shoot")
	#$BlasterShot.play()
	var blast_instance = blast.instantiate()
	blast_instance.global_position = $GunEnd.global_position
	var shooter_pos = get_parent().global_position
	if target.distance_to(shooter_pos) > 60:
		var direction_of_mouse= blast_instance.global_position.direction_to(target).normalized()
		blast_instance.set_direction(direction_of_mouse)
		blast_instance.dmg_enemies = true
		weapon.get_tree().get_root().add_child(blast_instance)
		blast_instance.rotation = global_rotation + deg_to_rad(90)
	can_shoot = false
		
func _on_gun_cooldown_timeout():
	can_shoot = true
