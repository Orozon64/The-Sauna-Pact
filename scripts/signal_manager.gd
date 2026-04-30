extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $PlayerArea
	match name:
		"FinnishRootNode":
			var wood = $WoodArea 
			wood.picked_up.connect(player._on_item_picked_up)
		"PolishRootNode":
			var beer = $BeerArea
			beer.picked_up.connect(player._on_item_picked_up)
			var towel = $TowelArea
			towel.picked_up.connect(player._on_item_picked_up)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
