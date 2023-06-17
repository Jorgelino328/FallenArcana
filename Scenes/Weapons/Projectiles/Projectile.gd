class_name Projectile extends RigidBody2D
@onready var speed = 20
var direction := Vector2.ZERO
var dmg_enemies = false 

func _ready():
	gravity_scale = 0

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed 
		global_position += velocity
	
func set_direction(direction: Vector2):
		self.direction = direction
		
func _on_body_entered(body):
	if body != RigidBody2D:
		queue_free()
