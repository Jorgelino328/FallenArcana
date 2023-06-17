extends Node
var music1 = load("res://Assets/music1.wav")
var music2 = load("res://Assets/music2.wav")
@onready var current_level := $Main_Menu
var reload := false

func _ready():
	connect_signals()
	$Audio/BackgroundMusic.play()

func connect_signals():
	if(current_level == $Game_Over):
		current_level.load_game.connect(_on_main_menu_new_game)
		reload = true
		current_level.menu.connect(_on_menu)
		current_level.quit.connect(_on_quit)
	elif(current_level == $Main_Menu):
		$Audio/BackgroundMusic.stream = music1
		$Audio/BackgroundMusic.play()
		current_level.new_game.connect(_on_main_menu_new_game)
		current_level.continue_game.connect(_on_main_menu_continue_game)
		current_level.settings.connect(_on_main_menu_settings)
		current_level.quit.connect(_on_quit)
	elif(current_level == $Settings):
		current_level.back_menu.connect(_on_settings_back_menu)
	else:
		$Audio/BackgroundMusic.stream = music2
		$Audio/BackgroundMusic.play()
		current_level.next_level.connect(_on_next_level)

func _on_next_level(level):
	var next_level = level.instantiate()
	change_level(next_level)

func _on_main_menu_new_game():
	var next_level = load("res://Scenes/Levels/Level1.tscn").instantiate()
	change_level(next_level)

func _on_main_menu_continue_game():
	var next_level = load("res://Scenes/Levels/Level3.tscn").instantiate()
	change_level(next_level)
	
func _on_settings_back_menu():
	var next_level = load("res://Scenes/UIs/Menus/Main_Menu/main_menu.tscn").instantiate()
	change_level(next_level)

func _on_main_menu_settings():
	var next_level = load("res://Scenes/UIs/Menus/Settings/Settings.tscn").instantiate()
	change_level(next_level)

func _on_quit():
	get_tree().quit()

func _on_menu():
	var next_level = load("res://Scenes/UIs/Menus/Main_Menu/main_menu.tscn").instantiate()
	change_level(next_level)
	
func change_level(next_level):
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level
	if(reload && current_level == $Level1):
		current_level.tut = false
	connect_signals()
	
	
