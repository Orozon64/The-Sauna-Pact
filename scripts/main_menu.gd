extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayButton.button_down.connect(_start_game)
	$CreditsButton.button_down.connect(_show_credits)
	$ReturnButton.button_down.connect(_return_to_menu)

func _start_game():
	var initial_data = {
		"objective_id":0,
		"Finn":
			{
				"position":"",
				"last_item":"",
				"money":50
			},
		"Pole":
			{
				"position":"",
				"last_item":"",
				"money":50
			}
	}
	var file = FileAccess.open("res://save_game.data", FileAccess.WRITE)
	file.store_var(initial_data)
	file.close()
	get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")

func _show_credits():
	$CreditsButton.hide()
	$PlayButton.hide()
	$ReturnButton.show()
	$Label.text = "Programming: Ignacy Guminiak, Michał Wójtowicz, Zuzanna Dróżdż, Jan Kukier\nNetwork management: Jan Kukier, Jan Maciejewski, Jakub Klimowicz\nGraphic design: Michał Wójtowicz, Zuzanna Dróżdż, Jan Maciejewski\nAudio design: Jakub Klimowicz, Jan Sarnecki, Ignacy Guminiak\nProject leader: Jakub Klimowicz\nSpecial thanks to mechatronics team :)\n"
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
func _return_to_menu():
	$CreditsButton.show()
	$PlayButton.show()
	$ReturnButton.hide()
	$Label.text = "The Sauna Pact"
