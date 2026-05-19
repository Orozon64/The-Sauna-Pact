extends CharacterBody2D

var cooldown = 0
var started = false
var ended = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		if cooldown > 0:
			cooldown -= 1
		
		if position.y >= 1030 or position.y <= 0: 
			velocity.y = 0
			#get_tree().change_scene_to_file("res://scenes/flyingGameOver.tscn")
			var gameOver = load("res://scenes/flyingGameOver.tscn")
			var gameOverScreen = gameOver.instantiate()
			get_tree().current_scene.add_child(gameOverScreen)
			gameOverScreen.position = Vector2(930, 430)
			get_tree().paused = true
			#get_tree().reload_current_scene()
		
	if get_tree().current_scene.get_node("ProgressBar").value >= 100 and !ended:
		ended = true
		get_tree().current_scene.get_node("Start").text = "Congratulations!"
		get_tree().current_scene.get_node("Start").visible = true
		get_tree().current_scene.get_node("Start").set("theme_override_colors/font_color", Color(0.461, 1.0, 0.429, 1.0))
		
		
	if ended:
		position.x += 9
		if position.x >= 2000:
			get_tree().change_scene_to_file("res://scenes/planeFalling.tscn")
	
	
func _physics_process(delta: float) -> void:
	if started and !ended:
		var gravity = get_gravity()
		gravity = 1480.0
		velocity.y += gravity * delta
		
		move_and_slide()
		for i in get_slide_collision_count():
			velocity.y = 0
			#get_tree().change_scene_to_file("res://scenes/flyingGameOver.tscn")
			var gameOver = load("res://scenes/flyingGameOver.tscn")
			var gameOverScreen = gameOver.instantiate()
			get_tree().current_scene.add_child(gameOverScreen)
			gameOverScreen.position = Vector2(930, 430)
			get_tree().paused = true
	
func _input(ev):
	
	if Input.is_key_pressed(KEY_SPACE) and cooldown == 0 and !ended:
		$FlySoundPlayer.play()
		if !started:
			started = true
		#print("Space")
		#print(DisplayServer.window_get_size().x)   
		velocity.y = -500.0
		cooldown = 7
	
