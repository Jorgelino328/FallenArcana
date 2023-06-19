extends Panel
@export var selected := false
@export var known_spell := false
func _process(delta):
	if(known_spell):
		$Spell.visible = true
	else:
		$Spell.visible = false
		
	if(selected):
		$Select.visible = true
	else:
		$Select.visible = false
