extends Control

@onready var score = $Score:
	set(value):
		score.text = Global.player_name + " : " + str(value)
		#score.text = Global.player_name + "Score - " + str(value)


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LoginScreen/login_screen.tscn")
	pass # Replace with function body.
