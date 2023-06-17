extends CharacterBody2D
@export var hp : int
@export var target : CharacterBody2D
@onready var speed = 2
@onready var animation := $AnimationPlayer
var phase := 1
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
	match(phase):
		1:
			if position.distance_to(target.position) > 500 && position.distance_to(target.position) < 1000 :
				gatling()
				direction = global_position.direction_to(target.global_position).normalized()
			else: 
				direction = Vector2.ZERO
		2:
			if $TimerSlam.is_stopped():
				direction = global_position.direction_to(target.global_position).normalized()
				if(target.position.distance_to(position) < 500):
					slam()
					$TimerSlam.start()
				
func _physics_process(delta):
	if position.distance_to(get_global_mouse_position()) > 10:
		look_at(target.position)
		rotation -= PI/2
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		animation.play("walking")
		global_position += velocity
		
func slam():
	animation.play("slam")
	if(animation.is_playing()):
		var dmg = 1000/target.position.distance_to(position)
		target.hp -= dmg
		print("DANO : ",dmg)

func gatling():
	animation.play("gatling_spin")
	match(randi_range( 1, 10 )):
		1:
			emit_signal("shooting",$SixShooter1,target.global_position)
		2:
			emit_signal("shooting",$SixShooter2,target.global_position)
		3:
			emit_signal("shooting",$SixShooter3,target.global_position)
		4:
			emit_signal("shooting",$SixShooter4,target.global_position)
		5:
			emit_signal("shooting",$SixShooter5,target.global_position)
		6:
			emit_signal("shooting",$SixShooter6,target.global_position)
		7:
			emit_signal("shooting",$SixShooter7,target.global_position)
		8:
			pass
		9:
			pass
		10:
			pass


func _on_phase_switch_timeout():
	if phase == 1:
		phase = 2
	else:
		phase = 1
	print("PHASE:",phase)
	
