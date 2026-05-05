extends Node2D

var items_for_current_player = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	match name:
		"FinnishRootNode":
			items_for_current_player = ["Wood", "Furnace", "Stones"]
			var player = $FinnCharacter 
			var wood = $WoodArea 
			wood.picked_up.connect(player._on_item_picked_up)
		"PolishRootNode":
			items_for_current_player = ["Towel", "Oil", "Lavender", "Beer"]
			var player = $PoleCharacter
			var beer = $BeerArea
			beer.picked_up.connect(player._on_item_picked_up)
			var towel = $TowelArea
			towel.picked_up.connect(player._on_item_picked_up)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
