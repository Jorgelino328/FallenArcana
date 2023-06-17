extends Level

var level = preload("res://Scenes/Levels/Level3.tscn")
var DialogueUI = preload("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
var tutorial2 = "res://Assets/Dialogue/Tutorial2.json"
var tutorial3 = "res://Assets/Dialogue/Tutorial3.json"
var gun_tut := true
var tut = true

func _ready():
		$Enemies/Outlaw_Basic.is_passive = true
		$Enemies/Outlaw_Basic2.is_passive = true
		if(!tut):
			$CanvasLayer/DialogueUI.queue_free()

func _process(delta):
	super._process(delta)
	if $Enemies.get_child_count() == 0 :
		emit_signal("next_level",level)
	if gun_tut && tut:
		if(!$SixShooter_og):
			var dialogue_instance = DialogueUI.instantiate()
			dialogue_instance.dialoguePath = tutorial2
			$CanvasLayer.add_child(dialogue_instance)
			gun_tut = false

func _on_pit_body_entered(body):
	if body == $Silas_Blackwood:
		emit_signal("next_level",game_over)
	elif body is PhysicsBody2D:
		body.queue_free()


func _on_door_body_entered(body):
	if body is RigidBody2D:
		$Door.queue_free()
		$Enemies/Outlaw_Basic.is_passive = false
		$Enemies/Outlaw_Basic2.is_passive = false


func _on_tutorial_dash_body_entered(body):
	if body is PhysicsBody2D && tut:
		var dialogue_instance = DialogueUI.instantiate()
		dialogue_instance.dialoguePath = tutorial3
		$CanvasLayer.add_child(dialogue_instance)
		$TutorialDash.queue_free()
