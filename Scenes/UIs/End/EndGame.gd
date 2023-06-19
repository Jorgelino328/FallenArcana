extends Control
signal menu()
signal quit()

func _on_btn_quit_pressed():
	emit_signal("quit")

func _on_btn_menu_pressed():
	emit_signal("menu")
