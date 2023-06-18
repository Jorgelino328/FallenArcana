extends Weapon

@export var pelletCount : int
@export var spread : float
@onready var animation := $ShootingAnimator
var can_shoot := true

func _on_shooting(spell,target):
	#if(spell.name == "Fire"):
	animation.play("shoot")
	#$WandShot.play()
	var spell_instance = spell.instantiate()
	spell_instance.global_position = $WandEnd.global_position
	var player_pos = get_parent().global_position
	if target.distance_to(player_pos) > 60:
		var direction_of_mouse = spell_instance.global_position.direction_to(target).normalized()
		spell_instance.set_direction(direction_of_mouse)
		spell_instance.dmg_enemies = true
		get_tree().get_root().add_child(spell_instance)
		spell_instance.rotation = global_rotation + deg_to_rad(90)


func _on_gun_cooldown_timeout():
		can_shoot = true

