class_name Level extends Node2D
var game_over = load("res://Scenes/UIs/Game_Over/Game_Over.tscn")
signal next_level(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Silas_Blackwood.hp <= 0):
		emit_signal("next_level",game_over)
