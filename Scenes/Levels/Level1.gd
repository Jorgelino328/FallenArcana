extends Level

var level = load("res://Scenes/UIs/End/EndGame.tscn")
var dialogue = "res://Assets/Dialogue/Level1.json"
var dialogueBoss = "res://Assets/Dialogue/Boss1.json"
var final_song := false 
@onready var fireBolt = $CanvasLayer/PlayerHUD/Inventory/GridContainer/Fire 
@onready var new_song = load("res://Assets/Audio/Dragon-Castle.mp3") 

func _ready():
	super._ready()
	var dialogue_instance = dialogueUI.instantiate()
	dialogue_instance.dialoguePath = dialogue
	$CanvasLayer.add_child(dialogue_instance)

func _process(delta):
	super._process(delta)
	if(!$CanvasLayer/Dialogue_UI):
		get_tree().paused = false
	else:
		get_tree().paused = true
	if !$Ogre_Mage:
		emit_signal("next_level",level)
	
func _on_pit_body_entered(body):
	if body == $Player:
		emit_signal("next_level",game_over)
	elif body is PhysicsBody2D:
		body.queue_free()

func _on_final_arena_body_entered(body):
	if(body.name == "Player" && !final_song):
		var dialogue_instance = dialogueUI.instantiate()
		dialogue_instance.dialoguePath = dialogueBoss
		$CanvasLayer.add_child(dialogue_instance)
		emit_signal("change_song",new_song)
		final_song = true


func _on_final_arena_body_exited(body):
	if $Ogre_Mage:
		body.global_position = Vector2(1200,1059)


func _on_outer_zone_body_entered(body):
	if(body is CharacterBody2D):
		body.global_position = Vector2(3008,144)
