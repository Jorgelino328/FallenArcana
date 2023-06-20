extends Level
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 3.0
@onready var rand = RandomNumberGenerator.new()
@onready var fireBolt = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Fire 

var level1 = load("res://Scenes/Levels/Level1.tscn")
var shake_strength: float = 0.0
var intro2_done := false
var intro3_done := false
var intro2 = "res://Assets/Dialogue/Intro2.json"
var intro3 = "res://Assets/Dialogue/Intro3.json"
var dialogue_instance

func _ready():
	super._ready()
	rand.randomize()
	$CanvasLayer/PlayerHUD.visible = false
	dialogue_instance = dialogueUI.instantiate()
	$CanvasLayer.add_child(dialogue_instance)

func intro_2():
	$Asha/AnimationPlayer.play("steal")
	$amulet.queue_free()
	dialogue_instance = dialogueUI.instantiate()
	dialogue_instance.dialoguePath = intro2
	$CanvasLayer.add_child(dialogue_instance)
	intro2_done = true
	$Timer.start()
	$Earthquake.play()
	
func intro_3():
	dialogue_instance = dialogueUI.instantiate()
	dialogue_instance.dialoguePath = intro3
	$CanvasLayer.add_child(dialogue_instance)
	$CanvasLayer/PlayerHUD.visible = true
	fireBolt.known_spell = true
	fireBolt.selected = true
	
func _process(delta):
	super._process(delta)
	if(!$CanvasLayer/Dialogue_UI):
		get_tree().paused = false
		if(!intro2_done):
			intro_2()
		if(!intro3_done):
			shake_strength = RANDOM_SHAKE_STRENGTH
			$Player/Camera2D.offset = get_random_offset()
			shake_strength = lerpf(shake_strength, 0, SHAKE_DECAY_RATE * delta)
	else:
		get_tree().paused = true
		
func get_random_offset():
	return Vector2(
		rand.randf_range(-shake_strength,shake_strength),
		rand.randf_range(-shake_strength,shake_strength)
	)

func _on_timer_timeout():
	intro3_done = true
	$Earthquake.stop()
	intro_3()


func _on_exit_body_entered(body):
	emit_signal("next_level",level1)


func _on_outer_zone_body_entered(body):
	body.global_position = Vector2(0,0)
