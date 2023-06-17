extends Area2D

@export var player : CharacterBody2D 
@onready var enemy  = preload("res://Scenes/Actors/Enemy/Outlaw_Melee.tscn") 
@export var enemy_max := 5
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
		enemy_instance.position = position
		get_parent().add_child(enemy_instance)
		enemy_amount += 1
	else:
		queue_free()
