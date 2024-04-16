extends Control


func _ready():
	Global.load_file()
	Global.show_players()
	$PlayersBg/Players.text = Global.players_list


func _process(_delta):
	if Input.is_action_just_pressed("full screen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#if Input.is_action_just_pressed("ui_accept"):
		#Global.player_name = $LineEditPlayerName.text
		#Global.login()
		#if Global.state:
			#$LineEditPlayerName.text = ""
			#$LineEditPlayerName.placeholder_text = "Player Not Found"
		#Global.state = false
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_login_button_pressed():
	Global.player_name = $LineEditPlayerName.text
	Global.login()
	if Global.state:
		$LineEditPlayerName.text = ""
		$LineEditPlayerName.placeholder_text = "Player Not Found"
	Global.state = false


func _on_sighup_button_pressed():
	Global.player_name = $LineEditPlayerName.text
	Global.save_game()
	Global.load_file()
	Global.show_players()
	$PlayersBg/Players.text = Global.players_list


func _on_button_pressed():
	Global.player_name = $LineEditPlayerName.text
	Global.remove_player()
	Global.load_file()
	Global.show_players()
	$PlayersBg/Players.text = Global.players_list


func _on_quit_button_pressed():
	get_tree().quit()


func _on_refresh_player_list_pressed():
	Global.load_file()
	Global.show_players()
	$PlayersBg/Players.text = Global.players_list
