extends Node

var player_name
var save_data = { "players":{} }
var high_score = 0
var default_player_data = {"players":{"no name":0}}
var state = false
var players_list

func os():
	print(OS.get_name())
	OS.alert("hello world")


func show_players():
	var file = FileAccess.open("user://players.txt", FileAccess.WRITE)
	var keys = save_data["players"].keys()
	var keys_len =len(keys) - 1
	while keys_len >= 0:
		file.store_string(keys[keys_len])
		file.store_string(" : ")
		file.store_string(str(save_data["players"][keys[keys_len]]))
		file.store_string("\n")
		keys_len -= 1
	
	file.close()
	file = FileAccess.open("user://players.txt", FileAccess.READ)
	players_list = file.get_as_text()
	file.close()


func login():
	var keys = save_data["players"].keys()
	var keys_len = len(keys) - 1
	while keys_len >= 0:
		if keys[keys_len] == player_name:
			#print(keys[keys_len])
			high_score = save_data["players"][player_name]
			get_tree().change_scene_to_file("res://scenes/game/game.tscn")
		else:
			#print("Player Not Found")
			state = true
		keys_len -= 1
	


func load_file():
	var file = FileAccess.open("user://player_data.json", FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		save_data = JSON.parse_string(json_data)
		#return save_data
	else:
		file = FileAccess.open("user://player_data.json", FileAccess.WRITE)
		file.store_string(str(default_player_data))
		#print("Made New player_data.json")
	
	var test = file.get_as_text()
	if test == "":
		file = FileAccess.open("user://player_data.json", FileAccess.WRITE)
		file.store_string(str(default_player_data))
		#print("Made New player_data.json")
	file.close()


func save_game():
	save_data["players"][player_name] = high_score
	var json_data = JSON.stringify(save_data)
	var file = FileAccess.open("user://player_data.json", FileAccess.WRITE)
	if file:
		file.store_string(json_data)
		#print(save_data["players"][player_name])
	else:
		#print("save_data not stored (file not found)")
		pass
	file.close()


func remove_player():
	save_data["players"].erase(player_name)
	var json_data = JSON.stringify(save_data)
	var file = FileAccess.open("user://player_data.json", FileAccess.WRITE)
	if file:
		file.store_string(json_data)
	else:
		#print("save_data not stored (file not found)")
		pass
	file.close()
