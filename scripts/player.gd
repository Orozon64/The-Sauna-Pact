#base class that finnish and polish players will inherit
extends Area2D
var inventory = [] #an array of objects of the collectible class
@export var speed = 100

var screen_size
var last_played_anim #the last walking animation played - this is used to play the right idle animation once the player stops moving

signal item_picked_up()

var touched_item_name = "" #the name of the collectible that the player is nearby
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
		$PlayerSprite.animation = $PlayerSprite.animation.replace("walk", "idle")
		$PlayerSprite.play()
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
	
	if Input.is_action_pressed("pick_up") and touched_item_name != "":
		inventory.push_back(touched_item_name)
		item_picked_up.emit()
		
	last_played_anim = 	$PlayerSprite.animation

func _on_item_area_entered(args):
	print("Item found")
