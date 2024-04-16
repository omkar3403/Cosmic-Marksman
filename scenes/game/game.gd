extends Node2D

@export var enemy_scenes: Array[PackedScene] = []	# Array to store enemy scenes

@onready var timer = $EnemySpawnTimer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen	# gos stands for Game Over Screen
@onready var pb = $ParallaxBackground
@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound

var player_name = Global.player_name
var scroll_speed = 300
var score = 0:
	set(value):
		score = value
		hud.score = score
var high_score = 0

func _ready():
	Engine.max_fps = 60
	print(player_name)
	var save_file = FileAccess.open("res://save.txt", FileAccess.READ)
	if save_file != null:
		high_score = int(save_file.get_as_text())
		save_file.close()
	else:
		high_score = 0
		#save_game()
	score = 0
	$Player.global_position = $PlayerSpawnPosition.global_position
	$Player.laser_shot.connect(_on_player_laser_shot)
	$Player.laser_shot2.connect(_on_player_laser_shot)
	$Player.killed.connect(_on_player_killed)

func _process(delta):
	if timer.wait_time > 0.3:
		timer.wait_time -= delta * 0.05
	elif timer.wait_time < 0.3:
		timer.wait_time = 0.3
	pb.scroll_offset.y += delta * scroll_speed
	if pb.scroll_offset.y >= 1080:
		pb.scroll_offset.y = 0
	if Input.is_action_just_pressed("quit"):
		Global.high_score = 0
		get_tree().change_scene_to_file("res://scenes/LoginScreen/login_screen.tscn")


#func save_game():
	#var save_file = FileAccess.open("res://save.txt", FileAccess.WRITE)
	##save_file.store_32(high_score)
	#save_file.store_string(str(high_score))
	#save_file.close()

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	$LaserContainer.add_child(laser)
	#laser_sound.play()

func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(20, 1900), 0)
	e.killed.connect(_on_enemy_killed)
	$EnemyContainer.add_child(e)
	e.hit.connect(_on_enemy_hit)

func _on_enemy_killed(points):
	score += points
	if score > Global.high_score:
		Global.high_score = score

func _on_enemy_hit():
	#hit_sound.play()
	pass

func _on_player_killed():
	gos.set_high_score(high_score)
	gos.set_score(score)
	Global.save_game()
	await get_tree().create_timer(1).timeout
	gos.visible = true
	#explode_sound.play()

