extends CharacterBody2D
@export var hp : int
@export var target : CharacterBody2D
@export var speed := 200
@onready var animation := $AnimationPlayer
var is_passive = false
var direction := Vector2.ZERO
var last_dir := Vector2.ZERO

signal shooting(weapon,target)

func _on_bullet_detector_body_entered(body):
	if(body is RigidBody2D):
		print("ouch")
		match(body.id):
			1:
				print(-2)
				if(body.dmg_enemies):
					hp -= 2
			2:
				if(body.dmg_enemies):
					hp -= 0.1
				
func _process(delta):
	if(hp <= 0):
		queue_free()
	if(position.distance_to(target.position) > 60):
		direction = global_position.direction_to(target.global_position).normalized()
	else: 
		direction = Vector2.ZERO
		
func _physics_process(delta):
	#if position.distance_to(get_global_mouse_position()) > 10:
	#	look_at(target.position)
	#	rotation -= PI/2
	velocity = direction * speed
	print(direction)
	if(direction.x > 0.5):
		animation.play("walking_right")
		last_dir = direction
		$Club.position = Vector2(7,13)
		$Club.rotation = deg_to_rad(90)
		$Club.show_behind_parent = false
	elif(direction.x < -0.5):
		animation.play("walking_left")
		last_dir = direction
		$Club.position = Vector2(-8,14)
		$Club.rotation = deg_to_rad(270)
		$Club.show_behind_parent = false
	elif(direction.y > 0.5):
		animation.play("walking_down")
		last_dir = direction
		$Club.position = Vector2(-18,24)
		$Club.rotation = deg_to_rad(180)
		$Club.show_behind_parent = false
	elif(direction.y < -0.5):
		animation.play("walking_up")
		last_dir = direction
		$Club.position = Vector2(20,-3)
		$Club.rotation = 0
		$Club.show_behind_parent = true
	elif(last_dir.x == 1):
		animation.play("idle_right")
	elif(last_dir.x == -1):
		animation.play("idle_left")
	elif(last_dir.y == -1):
		animation.play("idle_up")
	else:
		animation.play("idle_down")
	move_and_slide()

func _on_timer_timeout():
	if(!is_passive):
		emit_signal("shooting",$Club,target)
