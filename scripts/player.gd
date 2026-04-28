extends Area2D
var inventory = [] #an array of objects of the collectible class

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_towel_picked_up() -> void:
	inventory.push_back("towel")
