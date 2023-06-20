extends CharacterBody2D
@export var hp := 10
@export var target : CharacterBody2D
@export var speed := 200
@onready var animation := $AnimationPlayer
var direction := Vector2.ZERO
var last_dir := Vector2.ZERO

signal shooting(weapon,target)

func _on_bullet_detector_body_entered(body):
	if(body is RigidBody2D):
		match(body.id):
			1:
				if(body.dmg_enemies):
					hp -= 2
			2:
				if(body.dmg_enemies):
					hp -= 0.1
				
func _process(delta):
	if(hp <= 0):
		queue_free()
	if(global_position.distance_to(target.global_position) > 60):
		direction = global_position.direction_to(target.global_position).normalized()
	else: 
		direction = Vector2.ZERO
		
func _physics_process(delta):
	velocity = direction * speed
	if(direction.x > 0.5):
		animation.play("walking_right")
		last_dir = Vector2(1,0)
		$Club.position = Vector2(-7,18)
		$Club.rotation = deg_to_rad(270)
		$Club.show_behind_parent = false
	elif(direction.x < -0.5):
		animation.play("walking_left")
		last_dir = Vector2(-1,0)		
		$Club.position = Vector2(5,19)
		$Club.rotation = deg_to_rad(90)
		$Club.show_behind_parent = false
	elif(direction.y > 0.5):
		animation.play("walking_down")
		last_dir = Vector2(0,1)
		$Club.position = Vector2(-17,23)
		$Club.rotation = deg_to_rad(180)
		$Club.show_behind_parent = false
	elif(direction.y < -0.5):
		animation.play("walking_up")
		last_dir = Vector2(0,-1)
		$Club.position = Vector2(13,-4)
		$Club.rotation = 0
		$Club.show_behind_parent = true
	elif(last_dir.x == 1):
		animation.play("idle_right")
		$Club.position = Vector2(-7,18)
		$Club.rotation = deg_to_rad(270)
		$Club.show_behind_parent = false
	elif(last_dir.x == -1):
		animation.play("idle_left")
		$Club.position = Vector2(5,19)
		$Club.rotation = deg_to_rad(90)
		$Club.show_behind_parent = false
	elif(last_dir.y == -1):
		animation.play("idle_up")
		$Club.position = Vector2(13,-4)
		$Club.rotation = 0
		$Club.show_behind_parent = true
	else:
		animation.play("idle_down")
		$Club.position = Vector2(-17,23)
		$Club.rotation = deg_to_rad(180)
		$Club.show_behind_parent = false
	move_and_slide()

func _on_timer_timeout():
	emit_signal("shooting",$Club,target)
