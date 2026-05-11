extends Control


@export var n_options: int = 5 #number of images on spinners
@export var spinners: Array[Control] #Array of all active spinners
@export var loser_limit: int = 5 #number of spins before guaranteed win
var values: Array
var tween: Tween
var spin_count = 0 #counter of all spins
var prev_val=loser_limit
var complete_save_data
var pole_save_data
var money
var popupPlayed=false

func _ready() -> void:
	var loaded_file = FileAccess.open("res://save_game.data", FileAccess.READ)
	complete_save_data = loaded_file.get_var()
	pole_save_data = complete_save_data.get("Pole")
	money = pole_save_data.get("money")
	get_node("ProgressBar").value=money
	get_node("HBoxContainer/moneyStatus").text=str(money)
func god_Mode_Toggle(): #function for toggling between normal mode and everytime guaranteed win
	if loser_limit==1:
		loser_limit=prev_val
	else:
		prev_val=loser_limit
		loser_limit=1
func spin(): #function for spining all spiners
	if money>=5:
		
		money -= 5
		get_node("HBoxContainer/moneyStatus").text=str(money)
		values = []
		var spin_step = 1.0 / float(n_options)
		var offsets = {}
		
		for s in spinners: #generating outcome of every spin
			get_node("CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/SpinBtn").disabled=true
			var target_option = randi_range(0, n_options - 1) if spin_count % loser_limit!=loser_limit-1 else round((spin_count/loser_limit))
			values.append(target_option)
			
			offsets[s] = {
				'from': s.material.get_shader_parameter('y_offset'), 
				'to': 3.0 + target_option * spin_step
			}
			
		spin_count += 1
		#V animating the spin V
		if tween: 
			tween.kill()
			
		tween = get_tree().create_tween()
		
		tween.tween_method(
			func (v):
				for s in spinners:
					s.material.set_shader_parameter('y_offset', lerpf(offsets[s].from, offsets[s].to, v)),
			0.0, 1.0, 1.0
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
		tween.tween_callback(func ():
			for idx in spinners.size():
				spinners[idx].material.set_shader_parameter('y_offset', values[idx] * spin_step)
			var victory = true
			var victory_offset=spinners[0].material.get_shader_parameter('y_offset')
			for s in spinners:
				if s.material.get_shader_parameter('y_offset') != victory_offset:
					victory = false
			if victory:
				money += 75
			pole_save_data.set("money", money)
			complete_save_data.set("Pole", pole_save_data)
			var file = FileAccess.open("res://save_game.data", FileAccess.WRITE)
			file.store_var(complete_save_data)
			file.close()
			get_node("ProgressBar").value=money
			if money>=250:
				get_node("CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/ExitBtn").disabled=false
				if !popupPlayed:
					var popup=get_node("popup")
					popup.show()
					await get_tree().create_timer(2.0).timeout
					popup.hide()
					popupPlayed=true
					loser_limit=1000
			else:
				get_node("CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/ExitBtn").disabled=true
			get_node("HBoxContainer/moneyStatus").text=str(money)
			get_node("CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/SpinBtn").disabled=false
			)
	else:
		get_node("GameOverScreen").show()
func _on_restart_button_down():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func _on_exitbtn_button_down():
	get_tree().change_scene_to_file("res://scenes/polish_map.tscn")
