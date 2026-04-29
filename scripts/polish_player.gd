extends "player.gd"


func _on_beer_area_entered(args): # could be a way to make a general method - i will figure it out later
	touched_item_name = "beer"
	print(touched_item_name + "found")

