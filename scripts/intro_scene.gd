extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PolishPhoneSprite.animation = "Ring"
	$FinnishPhoneSprite.animation = "Ring"
	$NokiaAudioPlayer.play()

	$PolishPhoneSprite.play()
	$FinnishPhoneSprite.play()
	get_tree().create_timer(1.0).timeout.connect(timeout)


func timeout():
	$PolishPhoneSprite.stop()
	$FinnishPhoneSprite.stop()
	$PolishPhoneSprite.hide()
	$FinnishPhoneSprite.hide()
	var dialogue_window = preload("res://scenes/dialogue_window.tscn")
	add_child(dialogue_window.instantiate())
	
