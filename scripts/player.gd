#base class that finnish and polish players will inherit
extends Area2D
var inventory = [] #an array of objects of the collectible class
@export var speed = 100

var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = get_viewport_rect().get_center()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x > 0:
		$PlayerSprite.animation = "walk_right"
	elif velocity.y > 0:
		$PlayerSprite.animation = "walk_down" #this is not a mistake - godot's (0,0) coords are in the "top left corner", so y is posiitve if the vector is pointing downwards. Don't change!
	elif velocity.x < 0:
		$PlayerSprite.animation = "walk_left"
	elif velocity.y < 0:
		$PlayerSprite.animation = "walk_up"
		
		#now add code to return to the correct idle position once the player stops
