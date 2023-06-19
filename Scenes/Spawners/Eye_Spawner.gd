extends Area2D

@export var player : CharacterBody2D 
@export var spread : int
@onready var enemy  = preload("res://Scenes/Actors/Enemy/Eye.tscn") 
@export var enemy_max : int
var enemy_amount = 0
var spawner_on = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(player.global_position) < 1000 && !spawner_on:
		$SpawnerTimer.start()
		spawner_on = true


func _on_spawner_timer_timeout():
	if(enemy_amount < enemy_max):
		var enemy_instance = enemy.instantiate() 
		enemy_instance.target = player
		var min_x = position.x - spread
		var min_y = position.y - spread
		var max_x = position.x + spread
		var max_y = position.y + spread
		enemy_instance.position = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
		get_parent().add_child(enemy_instance)
		enemy_amount += 1
	else:
		queue_free()
