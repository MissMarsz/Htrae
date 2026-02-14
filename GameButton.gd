extends Button

# Changing from String to PackedScene creates the "Drop Zone" in the Inspector
@export var transition_delay: float = 1.0
@export var target_scene: PackedScene 
@onready var sprite = $AnimatedSprite2D
@onready var label = $Label

func _ready():
	# 1. Self-Setup
	self.pivot_offset = size / 2
	
	# 2. AUTO-CONNECT SIGNALS (This is the magic part)
	# This connects the signals to the functions below without using the Node Tab
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_unhover)
	
	if sprite:
		sprite.stop()
		sprite.frame = 0
		# Connect the sprite's signal to this script too
		#sprite.animation_finished.connect(_on_anim_finished)

# --- THE FUNCTIONS ---

func _on_hover():
	create_tween().tween_property(self, "scale", Vector2(1.05, 1.05), 0.1).set_trans(Tween.TRANS_CUBIC)

func _on_unhover():
	create_tween().tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_CUBIC)

# --- CLICK LOGIC ---
func _on_pressed():
	if sprite:
		# 1. Play Forward FAST
		sprite.speed_scale = 3.0 # Triple speed for snappiness
		sprite.frame = 0
		sprite.play("default")
		
		#check if get_tree() exist so we dont crash
		var tree = get_tree()
		if tree == null:
				return #exit if the tree isnt ready
		
		# 2. If it's a travel button, switch scenes
		if target_scene != null:
			await tree.create_timer(transition_delay).timeout
			tree.change_scene_to_packed(target_scene)
		
		# 3. If it's a selector button, wait for the animation to end, then reverse
		else:
			# Adjust this time (0.2) to match how long your 6 frames take at 3x speed
			await get_tree().create_timer(0.2).timeout
			
			# Play Backward even FASTER
			sprite.play("default", -4.0, true) 
			
			# One final safety check to make sure it stops at the start
			await get_tree().create_timer(0.15).timeout
			sprite.stop()
			sprite.frame = 0
