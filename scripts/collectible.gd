extends Area2D
signal picked_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	hide()
	picked_up.emit()
	get_node("CollisionShape2D").set_deferred("disabled", true) #the get_node could be replaced by a '$' symbol, but I'll keep it this way to make it more readable
