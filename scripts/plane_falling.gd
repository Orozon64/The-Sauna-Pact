extends Node2D
var speed = 0.1
var crashed = false
var cooldown = 6
var odejm = 8
var koniecAnim = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Plane.position)
	$Plane.position = Vector2(-239, -435)
	print($Plane.position)
	$CrashedPlane.visible = false
	$Explosion.visible = false
	$Polak.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !crashed:	
		if($Plane.position.x  < 761 and $Plane.position.y < 565):
			$Plane.position.x += speed
			$Plane.position.y += speed
			speed *= 1.06
		else:
			crashed = true
			$Explosion.visible = true
			$Plane.visible = false
	else:
		if cooldown == 0:
			$Explosion.visible = false
			$Polak.visible = true
			
			if !koniecAnim:
				if(odejm <= 30):
					$Polak.position.x += odejm
					$Polak.position.y += odejm - 30
					odejm *= 1.1
				else:
					$Polak.position.x -= -40 + odejm
					$Polak.position.y += odejm - 15
					odejm *= 1.01
				if $Polak.position.y >= 630:
					koniecAnim = true
				
		elif cooldown == 4:
			$CrashedPlane.visible = true
			
			cooldown -= 1
		else:
			cooldown -= 1

		
