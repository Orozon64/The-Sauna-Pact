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
			player.item_placed.connect(place_item)
			$ConstructionArea.body_entered.connect(player._on_enter_construction_site)
			$ConstructionArea.body_exited.connect(player._on_exit_construction_site)
			
			
		"PolishRootNode":
			last_item = file.get_var().get("Pole").get("last_item")
			items_for_current_player = ["Towel", "Sauna oil", "Beer"]
			player = $PoleCharacter
			$AirportArea.body_entered.connect(player._on_enter_airport)
			$AirportArea.body_exited.connect(player._on_exit_airport)

			$CasinoArea.body_entered.connect(player._on_enter_casino)
			$CasinoArea.body_exited.connect(player._on_exit_casino)

	if last_item != items_for_current_player[-1]:
		if last_item == "":
			current_item_name = items_for_current_player[0]
		
		else:
			current_item_name = items_for_current_player[items_for_current_player.find(last_item) + 1]
			if last_item == "Furnace":
				$FurnaceArea.position = Vector2(467.332, 241.607)
				$FurnaceArea.show()
		if current_item_name == "Sauna oil":
			var first_item = $OilArea
			first_item.show()
			get_node(first_item.name+"/CollisionShape2D").disabled = false
			first_item.picked_up.connect(player._on_item_picked_up)
			var second_item = $LavenderArea
			second_item.show()
			get_node(second_item.name+"/CollisionShape2D").disabled = false
			second_item.picked_up.connect(player._on_item_picked_up)
		else:
			var current_item = get_node(current_item_name+"Area")
			current_item.show()
			get_node(current_item_name+"Area/CollisionShape2D").disabled = false
			current_item.picked_up.connect(player._on_item_picked_up)

	file.close()
	

func place_item(item_name):
	match item_name:
		"Furnace":
			$FurnaceArea.position = Vector2(467.332, 241.607)
			$FurnaceArea.show()
			#then wait like half a sec so the player can see what they did
			get_tree().create_timer(0.5).timeout.connect(item_placed_timeout)
		"Stones":
			$FurnaceArea/Sprite2D.texture = load("res://images/sprites/furnaceFilled.png")
			get_tree().create_timer(0.5).timeout.connect(item_placed_timeout)

func item_placed_timeout():
	get_tree().change_scene_to_file("res://scenes/polish_map.tscn")
