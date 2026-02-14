class_name Player extends CharacterBody2D

@export var walk_speed := 100.0
@export var run_speed := 200.0
@export var inventory_data: InventoryData

@onready var sprite = $AnimatedSprite2D

var is_running := false
var current_speed := 100.0

func _process(delta):
	# 1. Input
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Tab Toggle
	if Input.is_action_just_pressed("ui_focus_next"):
		is_running = !is_running
		current_speed = run_speed if is_running else walk_speed

	# 3. Velocity
	if input.length() > 0:
		velocity = input * current_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, current_speed * 15 * delta)

	update_animation(input)
	move_and_slide()

func update_animation(input):
	var target = "idle"
	if input.length() > 0:
		target = "run" if is_running else "walk"
	
	if sprite.animation != target:
		sprite.play(target)
