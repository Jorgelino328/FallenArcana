extends Control
@onready var opt = $Options
@onready var Video = $Video
@onready var Audio = $Audio
signal back_menu()

func _ready():
	volume(0,0.5)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		toggle()
		
func toggle():
	visible = !visible
	get_tree().paused = visible



func show_and_hide(first,second):
	first.show()
	second.hide()
	
func _on_exit_pressed():
	get_tree().quit()


func _on_video_pressed():
	show_and_hide(Video,opt)


func _on_audio_pressed():
	show_and_hide(Audio,opt)


func _on_back_from_options_pressed():
	if(get_parent().name == "CanvasLayer"):
		get_parent().get_parent().paused = false
		get_tree().paused = false
		queue_free()
	else:
		emit_signal("back_menu")


func _on_full_screen_toggled(button_pressed):
	if(button_pressed):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_bordeless_toggled(button_pressed):
	if(button_pressed):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_v_sync_toggled(button_pressed):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_back_from_video_pressed():
	show_and_hide(opt,Video)


func _on_master_value_changed(value):
	volume(0,value)
	

func volume(bus_index,value):
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))


func _on_music_value_changed(value):
	volume(1,value)


func _on_sound_fx_value_changed(value):
	volume(2,value)


func _on_back_from_audio_pressed():
	show_and_hide(opt,Audio)
