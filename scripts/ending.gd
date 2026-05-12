extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EndingSprite.animation = "Drinking"
	$EndingSprite.play()
	get_tree().create_timer(5).timeout.connect(ending_timeout)
	get_tree().create_timer(10).timeout.connect(back_to_menu)
func ending_timeout():
	$EndingSprite.animation = "The End"
func back_to_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
