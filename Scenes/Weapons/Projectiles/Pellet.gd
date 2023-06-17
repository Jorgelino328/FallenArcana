extends Projectile
var id = 2
var pos_init : Vector2
@export var pellet_speed : float

func _ready():
	super._ready()
	speed = pellet_speed
	pos_init = position
	
	
func _process(delta):
	if(pos_init.distance_to(position) > 500):
		queue_free()
