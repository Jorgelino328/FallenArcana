class_name Projectile extends RigidBody2D
@onready var speed = 10
var direction := Vector2.ZERO
var dmg_enemies := false 
var friendly_fire := false
@onready var animation = $AnimationPlayer

func _ready():
	gravity_scale = 0

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed 
		global_position += velocity
		animation.play("shooting")
	if (!animation.is_playing()):
		queue_free()
func set_direction(direction: Vector2):
		self.direction = direction
		
