class_name Weapon extends Area2D
@export var equipped := false
var target := Vector2(0,0)
var in_pickup_area := false
signal picked_up(weapon)

func _ready():
	self.body_entered.connect(func(body): "_on_body_entered")
	self.body_exited.connect(func(body): "_on_body_exited")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if in_pickup_area:
			emit_signal("picked_up", self)
			in_pickup_area = false

func _on_body_entered(body):
	in_pickup_area = true

func _on_body_exited(body):
	in_pickup_area = false
