extends CharacterBody2D
@export var hp : int
@export var target : CharacterBody2D
@export var speed = 100
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
	if(position.distance_to(target.position) > 200 && position.distance_to(target.position) < 500):
		direction = global_position.direction_to(target.global_position).normalized()
	else: 
		direction = Vector2.ZERO
		
func _physics_process(delta):
	velocity = direction * speed
	if(direction.x > 0.5):
		animation.play("walking_right")
		$MageStaff.position = Vector2(53,-24)
		last_dir = Vector2(1,0)
	elif(direction.x < -0.5):
		animation.play("walking_left")
		$MageStaff.position = Vector2(-19,-24)
		last_dir = Vector2(-1,0)		
	elif(direction.y > 0.5):
		animation.play("walking_right")
		$MageStaff.position = Vector2(53,-24)
		last_dir = Vector2(0,1)
	elif(direction.y < -0.5):
		animation.play("walking_up")
		$MageStaff.position = Vector2(-19,-24)
		last_dir = Vector2(0,-1)
	elif(last_dir.x == 1):
		animation.play("idle_right")
		$MageStaff.position = Vector2(53,-24)
	elif(last_dir.x == -1):
		animation.play("idle_left")
		$MageStaff.position = Vector2(-19,-24)
	elif(last_dir.y == -1):
		animation.play("idle_right")
		$MageStaff.position = Vector2(53,-24)
	else:
		animation.play("idle_right")
		$MageStaff.position = Vector2(53,-24)
	move_and_slide()

func _on_timer_timeout():
	if(position.distance_to(target.position) < 500):
		emit_signal("shooting",$MageStaff,target.global_position)
