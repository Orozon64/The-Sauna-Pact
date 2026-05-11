extends ProgressBar

var started = false

@export var dev_mode = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_mode = FILL_BEGIN_TO_END
	if dev_mode:
		value = 98

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		value += 0.03
		if value >= 100:
			get_tree().change_scene_to_file("res://scenes/finnish_map.tscn") #and set the play_ending there to true

func _input(ev):
	if Input.is_key_pressed(KEY_SPACE):
		if !started:
			started = true
