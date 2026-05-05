extends Control
var is_line_finished

var dialogue_dict = {
	0:
		["Finn:No moi, what's up? How are things with you?", "Pole:Siema! Pretty chill, some studying, some gaming. What about you?", "Finn:Same here, been spending a lot of time outside lately. The weather's actually nice.", "Pole:Nice, kinda jealous. The weather here is all over the place.", "Finn:Yeah, I get that… hey, I've got an idea.", "Pole:Alright, let's hear it.", "Finn:Let's build a sauna. ", "Pole:Oh alright, bet.", "Finn:Knew you'd be in."],
}

@export var scene_id = 0 #info about which scene we're in

var line_id = 0
var current_scene_dialogue
var current_line
var character_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueRTLabel.text = ""
	current_scene_dialogue = dialogue_dict.get(scene_id)
	$TalkerSprite.texture = Image.load_from_file("res://images/sprites/Head" + current_scene_dialogue[0].split(":")[0] + ".png")
	current_line = current_scene_dialogue[0].split(":")[1]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	if Input.is_action_just_pressed("advance_dialogue") and visible: 
		if is_line_finished:
			if line_id < current_scene_dialogue.size()-1:
				line_id += 1
				$TalkerSprite.texture = load("res://images/sprites/Head" + current_scene_dialogue[line_id].split(":")[0]+ ".png")
				
				$DialogueRTLabel.text = current_scene_dialogue[line_id].split(":")[1]
				character_index = 0

			else:
				hide()
	elif not is_line_finished:
		await get_tree().create_timer(0.1).timeout	
		if character_index >= current_line.length():
			is_line_finished = true
		else:
			$DialogueRTLabel.text += current_line[character_index]
			character_index += 1

	