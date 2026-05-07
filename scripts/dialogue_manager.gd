extends Control
var is_line_finished

var dialogue_dict = {
	0:
		["Finn:No moi, what's up? How are things with you?", "Pole:Siema! Pretty chill, some studying, some gaming. What about you?", "Finn:Same here, been spending a lot of time outside lately. The weather's actually nice.", "Pole:Nice, kinda jealous. The weather here is all over the place.", "Finn:Yeah, I get that… hey, I've got an idea.", "Pole:Alright, let's hear it.", "Finn:Let's build a sauna. ", "Pole:Oh alright, bet.", "Finn:Knew you'd be in."],
	1:
		["Rudolf:Hello! My name is Rudolf and I will guide you through the game rules.", "Rudolf:First of all, move your character with  W(up), S(down), A(left), D(right). ", "Rudolf:To pick up an item from the ground or to interact with objects, press  E.", "Rudolf:Your goal is to get materials from both Polish and Finnish maps to hit a sauna together!", "Rudolf:You start as a Finnish character. After picking one or two materials (depending on the level) you will move to the second map and play as a second character.", "Rudolf:On the Finnish map, find wooden logs, an empty furnace and stones from the cave to fill the furnace.", "Rudolf:On the Polish map, find towels, plus oil and lavender to create the sauna aroma. As for the final item, go to the casino, win some money, then buy some beer in Żabka!","Rudolf:After collecting all of the materials and items, walk to the airport and fly to Finland!", "Rudolf:The game ends when you successfully build a sauna with the materials gathered and go in with both characters to chill out together.","Rudolf:Good luck!"]
}

@export var scene_id = 0 #info about which scene we're in

var line_id = 0
var current_scene_dialogue
var current_line
var character_index = 0
var next_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().get_center()
	match scene_id:
		0:
			next_scene = "tutorial"
		1:
			next_scene = "finnish_map"

	$DialogueRTLabel.text = ""
	current_scene_dialogue = dialogue_dict.get(scene_id)
	$TalkerSprite.animation = current_scene_dialogue[0].split(":")[0] + "Talk"
	$TalkerSprite.play()
	current_line = current_scene_dialogue[0].split(":")[1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	if Input.is_action_just_pressed("advance_dialogue") and visible: 
		if is_line_finished:
			if line_id < current_scene_dialogue.size()-1:
				$AdvanceTipLabel.hide()
				line_id += 1
				$TalkerSprite.animation = current_scene_dialogue[line_id].split(":")[0] + "Talk"
				$TalkerSprite.play()
				$DialogueRTLabel.text = ""
				is_line_finished = false
				character_index = 0
				current_line = current_scene_dialogue[line_id].split(":")[1]
			else:
				hide()
				get_tree().change_scene_to_file("res://scenes/" + next_scene+".tscn")

	elif not is_line_finished:
		if character_index >= current_line.length():
			is_line_finished = true
			$TalkerSprite.stop()
			$AdvanceTipLabel.show()
		else:
			$DialogueRTLabel.text += current_line[character_index]
			character_index += 1

	
