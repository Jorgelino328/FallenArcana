class_name Level extends Node2D
var game_over = load("res://Scenes/UIs/Game_Over/Game_Over.tscn")
var settings = load("res://Scenes/UIs/Menus/Settings/Settings.tscn")
var dialogueUI = preload("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
var paused = false
signal next_level(level)
signal change_song(new_song)

@onready var fire = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Fire
@onready var rock = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Earth
# Called when the node enters the scene treess for the first time.
func _ready():
	fire.known_spell = true
	fire.selected = true
	
func pause():
	var settings_instance = settings.instantiate()
	$CanvasLayer.add_child(settings_instance)
	paused = true
	get_tree().paused = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("esc"):
		if(!paused):
			pause()
		elif(paused):
			get_tree().paused = false
			paused = false
			$CanvasLayer/Settings.queue_free()
		
	if($Player.hp <= 0 && $Player.dead):
		emit_signal("next_level",game_over)
