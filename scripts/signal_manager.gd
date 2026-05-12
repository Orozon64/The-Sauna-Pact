extends Node2D

var items_for_current_player = []
var last_item
var current_item_name
var player
var play_ending = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BGMusicPlayer.play()
	var file = FileAccess.open("res://save_game.data", FileAccess.READ)
	match name:
		"FinnishRootNode":
			last_item = file.get_var().get("Finn").get("last_item")
			items_for_current_player = ["Wood", "Furnace", "Stones", "Filled furnace"]
			player = $FinnCharacter
			player.item_placed.connect(place_item)
			
			$ConstructionArea.body_entered.connect(player._on_enter_construction_site)
			$ConstructionArea.body_exited.connect(player._on_exit_place)
			
			$Cave.body_entered.connect(player._on_enter_cave)
			$Cave.body_exited.connect(player._on_exit_place)
		"PolishRootNode":
			last_item = file.get_var().get("Pole").get("last_item")
			items_for_current_player = ["Towel", "Sauna oil", "Beer"]
			player = $PoleCharacter
			$AirportArea.body_entered.connect(player._on_enter_airport)
			$AirportArea.body_exited.connect(player._on_exit_place)

			$CasinoArea.body_entered.connect(player._on_enter_casino)
			$CasinoArea.body_exited.connect(player._on_exit_place)

			$StoreArea.body_entered.connect(player._on_enter_store)
			$StoreArea.body_exited.connect(player._on_exit_place)
		"CaveLevel":
			player = $FinnCharacter
			last_item = file.get_var().get("Finn").get("last_item")
			items_for_current_player = ["Wood", "Furnace", "Stones", "Filled furnace"]

	if last_item != items_for_current_player[-1]:
		if last_item == "":
			current_item_name = items_for_current_player[0]
		elif last_item == "Sauna oil":
			player.can_enter_store_and_casino = true
			current_item_name = "Beer"
		else:
			current_item_name = items_for_current_player[items_for_current_player.find(last_item) + 1]
			if (last_item == "Furnace" and name != "CaveLevel") or last_item == "Stones":
				$Furnace.position = Vector2(467.332, 241.607)
				$Furnace.show()

		if current_item_name != "Beer" and !(current_item_name == "Stones" and name != "CaveLevel") and current_item_name != "Filled furnace":
			if current_item_name == "Sauna oil":
				var first_item = $Oil
				first_item.show()
				get_node(first_item.name+"/CollisionShape2D").disabled = false
				first_item.picked_up.connect(player._on_item_picked_up)
				var second_item = $Lavender
				second_item.show()
				get_node(second_item.name+"/CollisionShape2D").disabled = false
				second_item.picked_up.connect(player._on_item_picked_up)
			else:
				var current_item = get_node(current_item_name)
				current_item.show()
				get_node(current_item_name+"/CollisionShape2D").disabled = false
				current_item.picked_up.connect(player._on_item_picked_up)
	else:
		play_ending = true
	file.close()
	if play_ending:
		$DialogueControl.show()
		var polish_player = preload("res://scenes/polish_player.tscn")
		add_child(polish_player.instantiate())
		$FinnCharacter.ready_to_build = true
		$FinnCharacter.build.connect(_on_player_begin_building)



func _on_player_begin_building():
	$BuildingSoundPlayer.play()
	$SaunaBuildingSprite.show()
	$SaunaBuildingSprite.animation = "Building"
	$SaunaBuildingSprite.play()
	get_tree().create_timer(3).timeout.connect(finish_building)
func finish_building():
	$SaunaBuildingSprite.stop()
	$SaunaBuildingSprite.hide()
	$ConstructionArea.hide()
	$ConstructionArea/CollisionShape2D.disabled = true
	$Sauna.show()
	$Sauna/CollisionShape2D.disabled = false
	$Sauna.body_entered.connect(player._on_enter_sauna)

func place_item(item_name):
	match item_name:
		"Furnace":
			$Furnace.position = Vector2(467.332, 241.607)
			$Furnace.show()
			#then wait like half a sec so the player can see what they did
			get_tree().create_timer(0.5).timeout.connect(item_placed_timeout)
		"Stones":
			player.last_item = "Filled furnace"
			player.save_game()
			$Furnace/Sprite2D.texture = load("res://images/sprites/furnaceFilled.png")
			get_tree().create_timer(0.5).timeout.connect(item_placed_timeout)
		
func item_placed_timeout():
	get_tree().change_scene_to_file("res://scenes/polish_map.tscn")


	