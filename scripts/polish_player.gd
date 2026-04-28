extends "player.gd"


func _on_towel_picked_up() -> void:
	inventory.push_back("towel")