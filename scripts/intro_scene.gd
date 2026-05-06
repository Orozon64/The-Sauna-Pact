extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueControl.hide()
	$PolishPhoneSprite.animation = "Ring"
	$FinnishPhoneSprite.animation = "Ring"

	$PolishPhoneSprite.play()
	$FinnishPhoneSprite.play()
	get_tree().create_timer(4.0).timeout.connect(timeout)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func timeout():
	$PolishPhoneSprite.stop()
	$FinnishPhoneSprite.stop()
	$PolishPhoneSprite.hide()
	$FinnishPhoneSprite.hide()
	$DialogueControl.show()