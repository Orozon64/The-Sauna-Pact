#base class that finnish and polish players will inherit
extends CharacterBody2D
#var inventory = [] #an array of objects of the collectible class
var last_item
@export var speed = 1

var screen_size
var last_played_anim #the last walking animation played - this is used to play the right idle animation once the player stops moving
var complete_save_data #the save data for both characters
var character_name

var touched_item_name = "" #the name of the collectible that the player is nearby
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_name = name.replace("Character", "")

	var loaded_file = FileAccess.open("res://save_game.data", FileAccess.READ)
	complete_save_data = loaded_file.get_var()
	var current_character_save_data = complete_save_data.get(character_name)
	print(current_character_save_data)
	position = current_character_save_data.get("position")
	#inventory = current_character_save_data.get("inventory")
	
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO # The player's movement vector.
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
	
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_collide(velocity)

	if velocity.x > 0:
		$PlayerSprite.animation = "walk_right"
	elif velocity.y > 0:
		$PlayerSprite.animation = "walk_down" #this is not a mistake - godot's (0,0) coords are in the "top left corner", so y is posiitve if the vector is pointing downwards. Don't change!
	elif velocity.x < 0:
		$PlayerSprite.animation = "walk_left"
	elif velocity.y < 0:
		$PlayerSprite.animation = "walk_up"
	
		
	last_played_anim = 	$PlayerSprite.animation

func _on_item_picked_up(item_name):
	touched_item_name = item_name.replace("Area", "")
	print(touched_item_name + " found!")
	#inventory.push_back(touched_item_name)
	last_item = touched_item_name
	#after finding the item, switch players 

	var current_scene_save_data = {"position":position, "last_item":last_item}
	complete_save_data.set(character_name, current_scene_save_data)
	

	var file = FileAccess.open("res://save_game.data", FileAccess.WRITE)
	file.store_var(complete_save_data)
	file.close()

	if last_item != "Oil":
		if get_parent().name == "FinnishRootNode":
			get_tree().change_scene_to_file("res://scenes/polish_map.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/finnish_map.tscn")
