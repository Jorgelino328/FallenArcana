extends Level

var level = load("res://Scenes/UIs/End/EndGame.tscn")
var gun_tut := true
var dialogue = "res://Assets/Dialogue/Level1.json"
@onready var fireBolt = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Fire 

func _ready():
	super._ready()
	var dialogue_instance = dialogueUI.instantiate()
	dialogue_instance.dialoguePath = dialogue
	$CanvasLayer.add_child(dialogue_instance)

func _process(delta):
	super._process(delta)
	if !$Ogre_Mage:
		emit_signal("next_level",level)
	
func _on_pit_body_entered(body):
	if body == $Player:
		emit_signal("next_level",game_over)
	elif body is PhysicsBody2D:
		body.queue_free()

