class_name Level extends Node2D
var game_over = load("res://Scenes/UIs/Game_Over/Game_Over.tscn")
var dialogueUI = preload("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
signal next_level(level)

@onready var fire = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Fire
@onready var rock = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Earth
# Called when the node enters the scene treess for the first time.
func _ready():
	fire.known_spell = true
	fire.selected = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Player.hp <= 0):
		emit_signal("next_level",game_over)
