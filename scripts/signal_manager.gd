extends Node2D

var items_for_current_player = []
var last_item
var current_item_name
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://save_game.data", FileAccess.READ)
	match name:
		"FinnishRootNode":
			last_item = file.get_var().get("Finn").get("last_item")
			items_for_current_player = ["Wood", "Furnace", "Stones"]
			player = $FinnCharacter
			
		"PolishRootNode":
			last_item = file.get_var().get("Pole").get("last_item")
			items_for_current_player = ["Towel", "Oil", "Lavender", "Beer"]
			player = $PoleCharacter

	if last_item == "":
		current_item_name = items_for_current_player[0]
	else:
		current_item_name = items_for_current_player[items_for_current_player.find(last_item) + 1]
	var current_item = get_node(current_item_name+"Area")
	current_item.show()
	get_node(current_item_name+"Area/CollisionShape2D").disabled = false
	current_item.picked_up.connect(player._on_item_picked_up)

	file.close()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
