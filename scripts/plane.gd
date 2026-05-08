extends CharacterBody2D

var cooldown = 0
var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		if cooldown > 0:
			cooldown -= 1
			
		if position.y >= DisplayServer.window_get_size().y / 2 or position.y <= (0 - DisplayServer.window_get_size().y) / 2:
			velocity.y = 0
			#get_tree().change_scene_to_file("res://scenes/flyingGameOver.tscn")
			var gameOver = load("res://scenes/flyingGameOver.tscn")
			var gameOverScreen = gameOver.instantiate()
			get_tree().current_scene.add_child(gameOverScreen)
			gameOverScreen.position = Vector2(0, 0)
			get_tree().paused = true
			#get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	if started:
		var gravity = get_gravity()
		velocity.y += gravity.y * delta
		
		move_and_slide()
		for i in get_slide_collision_count():
			velocity.y = 0
			#get_tree().change_scene_to_file("res://scenes/flyingGameOver.tscn")
			var gameOver = load("res://scenes/flyingGameOver.tscn")
			var gameOverScreen = gameOver.instantiate()
			get_tree().current_scene.add_child(gameOverScreen)
			gameOverScreen.position = Vector2(0, 0)
			get_tree().paused = true

func _input(ev):
	
	if Input.is_key_pressed(KEY_SPACE) and cooldown == 0:
		if !started:
			started = true
		print("Space")
		print(DisplayServer.window_get_size().x)   
		velocity.y = -400.0  
		cooldown = 7
	
