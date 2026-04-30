extends Area2D
class_name Collectible
signal picked_up(name)

var can_be_picked_up = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player = $PlayerArea
	#picked_up.connect(player._on_item_picked_up)
	area_entered.connect(_on_player_entered_area)
	area_exited.connect(_on_player_exited_area)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("pick_up") and can_be_picked_up:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		picked_up.emit(name)

func _on_player_entered_area(args):
	can_be_picked_up = true

func _on_player_exited_area(args):
	can_be_picked_up = false
