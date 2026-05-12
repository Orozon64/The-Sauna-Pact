extends StaticBody2D

var pos = 300
#var rng = RandomNumberGenerator.new()
#var random = rng.randf_range(0, 400)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(pos, position.y)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos -= 5;
	position = Vector2(pos, position.y)
	if(position.x <= -1500):
		queue_free()
		
