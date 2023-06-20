extends CharacterBody2D
@export var hp := 5
@export var target : CharacterBody2D
@export var speed := 200
@onready var animation := $AnimationPlayer
var direction := Vector2.ZERO

signal shooting(weapon,target)

func _ready():
	animation.play("flying")
	
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
	if(global_position.distance_to(target.global_position) > 500):
		direction = global_position.direction_to(target.global_position).normalized()
	else: 
		direction = Vector2.ZERO
		
func _physics_process(delta):
	if position.distance_to(get_global_mouse_position()) > 10:
		$Blaster.look_at(target.global_position)
		$Blaster.rotation -= PI/2

	if direction != Vector2.ZERO:
		velocity = direction * speed
		move_and_slide()

func _on_timer_timeout():
	if(randi_range(1,3) == 1 && global_position.distance_to(target.global_position) < 500):
		emit_signal("shooting",$Blaster,target.global_position)
		
