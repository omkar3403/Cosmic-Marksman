class_name Player extends CharacterBody2D

@export var speed = 900
@export var dash_speed = 3
@export var rate_of_fire = 0.15
@onready var laser_shooter = $LaserShooter
@onready var laser_shooter2 = $LaserShooter2
var laser_scene = preload("res://scenes/laser/laser.tscn")
var shoot_cooldown := false

signal laser_shot(laser_scene, location)
signal laser_shot2(laser_scene, location)
signal killed

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cooldown:
			shoot_cooldown = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cooldown = false
	
	if Input.is_action_pressed("dash"):
		$ShipThruster.visible = true
		$ShipThruster2.visible = true
		$BottomLeftThruster.visible = true
		$BottomRightThruster.visible = true
	else:
		$ShipThruster.visible = false
		$ShipThruster2.visible = false
		$BottomLeftThruster.visible = false
		$BottomRightThruster.visible = false

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var dash = Input.is_action_pressed("dash")
	velocity = input_direction * speed
	if dash:
		velocity = input_direction * speed * dash_speed
	else:
		pass
	var ship_pos = Vector2(get_global_mouse_position() - global_position)
	velocity = ship_pos
	move_and_slide()
	
	#global_position = get_global_mouse_position()
	#speed = Input.get_last_mouse_velocity()
	#speed = sqrt(speed.x * speed.x + speed.y * speed.y)
	#if ship_pos.length() > 10:
		#ship_pos = ship_pos.normalized() * 10
	#var mouse_position = get_global_mouse_position()
	#velocity = position.direction_to(mouse_position) * speed
	#if position.distance_to(mouse_position) > 5:
		#move_and_slide()
	#global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)


func shoot():
	laser_shot.emit(laser_scene, laser_shooter.global_position)
	laser_shot2.emit(laser_scene, laser_shooter2.global_position)


func die():
	killed.emit()
	queue_free()
