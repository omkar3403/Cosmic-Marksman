extends Control

func _process(_delta):
	if Input.is_action_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/LoginScreen/login_screen.tscn")
	if Input.is_action_pressed("retry"):
		get_tree().reload_current_scene()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "Score - " + str(value)

func set_high_score(value):
	$Panel/HighScore.text = "HighScore - " + str(Global.high_score)

func _on_button_pressed():
	Global.high_score = 0
	get_tree().change_scene_to_file("res://scenes/LoginScreen/login_screen.tscn")
