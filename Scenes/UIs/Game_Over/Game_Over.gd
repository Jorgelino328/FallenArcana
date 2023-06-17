extends Control
signal load_game()
signal menu()
signal quit()

func _on_btn_quit_pressed():
	emit_signal("quit")

func _on_btn_menu_pressed():
	emit_signal("menu")

func _on_btn_load_pressed():
	emit_signal("load_game")
