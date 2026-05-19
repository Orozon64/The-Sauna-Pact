extends Node2D

var cooldown = 40
var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plane = get_node("Plane")
	plane.position = Vector2(930, 440)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		get_node("SkyBox").scroll_offset.x -= 1
		if cooldown == 0 and get_node("ProgressBar").value <= 90:
			var obstacle = load("res://scenes/flyingObstacle.tscn")
			var newObstacle = obstacle.instantiate()
			var newObstacleUpper = obstacle.instantiate()
			add_child(newObstacle)
			add_child(newObstacleUpper)
			var rng = RandomNumberGenerator.new()
			var random = rng.randf_range(150, 750)
			#var random = 100
			newObstacle.position = Vector2(1550, random)
			newObstacleUpper.position = Vector2(1550, random - 1100)
			cooldown = 100
			#print("New Object")
		else:
			cooldown -= 1
			

func _input(ev):
	if Input.is_key_pressed(KEY_SPACE):
		if !started:
			get_node("Start").visible = false
			started = true
