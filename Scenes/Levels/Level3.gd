extends Level

var level = load("res://Scenes/UIs/Menus/Main_Menu/main_menu.tscn")

func _process(delta):
	super._process(delta)
	if($Boss.hp <= 0):
		print("boss morto")
		emit_signal("next_level",level)
