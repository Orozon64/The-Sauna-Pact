#base class that finnish and polish players will inherit
extends CharacterBody2D
var last_item
@export var speed = 1

var screen_size
var last_played_anim #the last walking animation played - this is used to play the right idle animation once the player stops moving
var complete_save_data #the save data for both characters
var character_name

var touched_item_name = "" #the name of the collectible that the player is nearby

var place_name = "" #the name of the place a player is on - casino/store/construction site

var ready_to_build = false

var money = 0
signal item_placed(item_name)

signal build()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_name = name.replace("Character", "")

	var loaded_file = FileAccess.open("res://save_game.data", FileAccess.READ)
	complete_save_data = loaded_file.get_var()
	var current_character_save_data = complete_save_data.get(character_name)
	print(complete_save_data)
	if current_character_save_data.get("last_item") == "":
		position = $"../StartingPoint".position
	else:
		position = current_character_save_data.get("position")
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

	if Input.is_action_just_pressed("item_interact"):
		if place_name == "construction site":
			if (touched_item_name == "Furnace" or touched_item_name == "Stones"):
				item_placed.emit(touched_item_name)
			elif ready_to_build:
				build.emit()
		elif place_name == "airport" and touched_item_name == "Beer":
			get_tree().change_scene_to_file("res://scenes/flying.tscn")
		elif place_name == "casino":
			get_tree().change_scene_to_file("res://scenes/casino_minigame.tscn")
		elif place_name == "store" and money >= 50:
			_on_item_picked_up("Beer")
		

func _on_item_picked_up(item_name): #this entire function feels very unoptimized, try to smmoothen it out
	touched_item_name = item_name
	print(touched_item_name + " found!")
	if !((touched_item_name == "Oil" and last_item != "Lavender") or (touched_item_name == "Lavender" and last_item != "Oil")):

		if touched_item_name == "Oil" or touched_item_name == "Lavender":
			last_item = "Sauna oil"
		else:
			last_item = touched_item_name
		
		var current_scene_save_data = {"position":position, "last_item":last_item, "money":money}
		complete_save_data.set(character_name, current_scene_save_data)
		var file = FileAccess.open("res://save_game.data", FileAccess.WRITE)
		file.store_var(complete_save_data)
		file.close()

		if touched_item_name != "Furnace" and touched_item_name != "Stones" and touched_item_name != "Beer":
			if get_parent().name == "FinnishRootNode":
				get_tree().change_scene_to_file("res://scenes/polish_map.tscn")
			else:
				get_tree().change_scene_to_file("res://scenes/finnish_map.tscn")
		
	else:
		last_item = touched_item_name

func _on_enter_construction_site(args):
	place_name = "construction site"		 

func _on_enter_airport(args):
	place_name = "airport"		 

func _on_enter_casino(args):
	place_name = "casino"

func _on_enter_store(args):
	place_name = "store"		 

func _on_exit_place(args):
	place_name = ""