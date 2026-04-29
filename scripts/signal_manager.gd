extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $PlayerArea
	match name:
		"FinnishRootNode":
			var wood = $WoodArea
			wood.area_entered.connect(wood.picked_up)
		"PolishRootNode":
			var beer = $BeerArea
			beer.area_entered.connect(player._on_beer_area_entered)
			var towel = $TowelArea
			towel.area_entered.connect(player._on_item_area_entered)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
