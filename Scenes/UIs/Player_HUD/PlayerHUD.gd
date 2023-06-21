extends Control
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HealthBar.max_value = 20
	$HealthBar.value = player.hp
	
	$DashLabel/DashAmount.text = " %.1f" %player.get_node("DashCooldown").time_left
	
	
