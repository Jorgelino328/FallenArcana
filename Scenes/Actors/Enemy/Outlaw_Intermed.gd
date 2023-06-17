extends CharacterBody2D
@export var hp : int
@export var target : CharacterBody2D
@export var speed = 100
@onready var animation := $AnimationPlayer
var direction := Vector2.ZERO

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
	if(position.distance_to(target.position) > 500):
		direction = global_position.direction_to(target.global_position).normalized()
	else: 
		direction = Vector2.ZERO
		
func _physics_process(delta):
	if position.distance_to(target.global_position) > 10:
		look_at(target.position)
		rotation -= PI/2
		
	if direction != Vector2.ZERO:
		velocity = direction * speed
		animation.play("walking")
		move_and_slide()
	else:
		animation.pause()

func _on_timer_timeout():
	emit_signal("shooting",$Shotgun,target.global_position)
