extends CharacterBody2D

@export var speed = 200
@onready var current_speed = speed
@export var dash_speed = 800
@export var hp : int
@export var map : TileMap 
@onready var mv_animation := $MovementAnimator
@onready var ac_animation := $ActionAnimator
var equipped_right = null
var equipped_left = null
var input_direction := Vector2.ZERO
var last_dir := Vector2.ZERO
var can_dash := true
signal game_over()
signal shooting(weapon,target)

func get_input():
	#if position.distance_to(get_global_mouse_position()) > 10:
	#	look_at(get_global_mouse_position())
	#	rotation -= PI/2
	#if position.distance_to(get_global_mouse_position()) > 60:
	#	if(equipped_right):
	#		equipped_right.look_at(get_global_mouse_position())
	#		equipped_right.rotation -= PI/2
	#	if(equipped_left):
	#		equipped_left.look_at(get_global_mouse_position())
	#		equipped_left.rotation -= PI/2
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * current_speed
	if(velocity.x > 1):
		mv_animation.play("walking_right")
		last_dir = input_direction
	elif(velocity.x < -1):
		mv_animation.play("walking_left")
		last_dir = input_direction
	elif(velocity.y > 1):
		mv_animation.play("walking_down")
		last_dir = input_direction
	elif(velocity.y < -1):
		mv_animation.play("walking_up")
		last_dir = input_direction
	elif(last_dir.x > 1):
		mv_animation.play("idle_right")
	elif(last_dir.x < -1):
		mv_animation.play("idle_left")
	elif(last_dir.y < -1):
		mv_animation.play("idle_up")
	else:
		mv_animation.play("idle_down")

func _process(delta):
	if(Input.is_action_just_pressed("drop_weapon") && (equipped_right || equipped_left)):
		if equipped_right:
			equipped_right.get_parent().remove_child(equipped_right)
			equipped_right.equipped = false
			map.add_sibling(equipped_right)
			equipped_right.position = position
			equipped_right = null
		elif equipped_left:
			equipped_left.get_parent().remove_child(equipped_left)
			equipped_left.equipped = false
			map.add_sibling(equipped_left)
			equipped_left.position = position
			equipped_right = null
	if Input.is_action_just_pressed("l_mouse"):
		if equipped_right != null:
			if equipped_right.can_shoot:
				emit_signal("shooting",equipped_right,get_global_mouse_position())
		if equipped_left != null:
			if equipped_left.can_shoot:
				emit_signal("shooting", equipped_left,get_global_mouse_position())	
		
func _physics_process(delta):
	get_input()
	if Input.is_action_just_pressed("dash") && can_dash:
		dash()
		
	if(ac_animation.is_playing()):
		current_speed = dash_speed
	else:
		current_speed = speed
		$BulletDetector/CollisionShape2D.set_disabled(false)	
		$BodyCollision.set_disabled(false)	
	move_and_slide()

func dash():
	$BulletDetector/CollisionShape2D.set_disabled(true)
	$BodyCollision.set_disabled(true)
	ac_animation.play("dash")
	can_dash = false
	$DashCooldown.start()

func _on_picked_up(weapon):
	if !equipped_right:
		weapon.equipped = true
		weapon.get_parent().remove_child(weapon)
		$PlayerHandRight/HandRightCollision.add_sibling(weapon)
		weapon.position = $PlayerHandRight.position - Vector2(-30,13)
		equipped_right = weapon
	elif !equipped_left:
		weapon.equipped = true
		weapon.get_parent().remove_child(weapon)
		$PlayerHandLeft/HandLeftCollision.add_sibling(weapon)
		weapon.position = $PlayerHandLeft.position - Vector2(30,13)
		equipped_left = weapon	
	else:
		pass


func _on_bullet_detector_body_entered(body):
	if(body is RigidBody2D):
		match(body.id):
			1:
				hp -= 2
			2:
				hp -= 0.1

func _on_dash_cooldown_timeout():
	can_dash = true
	$DashCooldown.stop()

