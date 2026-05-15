extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$FinnishPhoneSprite.animation = "Ring"
	$FinnishPhoneSprite.play()
	$NokiaAudioPlayer.play()
	await get_tree().create_timer(5.0).timeout

	$FinnishPhoneSprite.stop()
	$NokiaAudioPlayer.stop()
	$PolishPhoneSprite.animation = "Ring"
	$PolishPhoneSprite.play()
	$PolishPhoneAudioPlayer.play()
	await get_tree().create_timer(8.0).timeout

	$PolishPhoneSprite.stop()
	$PolishPhoneAudioPlayer.stop()

	$PolishPhoneSprite.hide()
	$FinnishPhoneSprite.hide()
	var dialogue_window = preload("res://scenes/dialogue_window.tscn")
	add_child(dialogue_window.instantiate())
	