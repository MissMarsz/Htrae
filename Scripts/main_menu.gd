extends Control

# These must match your new names in the Scene Tree exactly
@onready var main_menu_buttons = $"MainMenuButton" 
@onready var settings_panel = $Options 

# Reference to your animated button sprite
@onready var start_sprite = $MainMenuButton/StartButton/AnimatedSprite2D

var cursor_texture = preload("res://itch_free_thigss/UI/Pointers/01.png")

func _ready():
	# 1. Setup Visibility
	main_menu_buttons.visible = true
	if settings_panel:
		settings_panel.visible = false
	
	# 2. Fix the Sprite Sheet issue
	# This ensures the sprite only shows the first frame and isn't a "sheet"
	if start_sprite:
		start_sprite.stop()
		start_sprite.frame = 0

func _on_start_pressed():
	# This plays your 6-frame animation when clicked
	if start_sprite:
		start_sprite.play()
	
	# Wait a tiny bit for the animation to play, then change scenes
	#await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/character_select.tscn")
	
#func _on_settings_pressed() -> void:
	#main_menu_buttons.visible = false
func _on_settings_pressed():
	# This replaces the menu with the settings scene
	get_tree().change_scene_to_file("res://Scenes/settings_menu.tscn")

func _on_quit_pressed() -> void:
	# 1. Disable the buttons so the player can't click 'Start' while quitting
	main_menu_buttons.process_mode = Node.PROCESS_MODE_DISABLED
	
	# 2. Create a Tween to fade the screen to black and show the label
	var tween = create_tween()
	# This fades the black rectangle from 0 to 1 alpha over 2 seconds
	tween.tween_property($FadeLayer/ColorRect, "modulate:a", 1.0, 2.0)
	# This fades the "Bye!" label in at the same time
	tween.parallel().tween_property($FadeLayer/ColorRect/Label, "modulate:a", 1.0, 2.0)
	
	# 3. Fade the music out slowly
	var music_bus = AudioServer.get_bus_index("Master")
	tween.parallel().tween_method(
		func(value): AudioServer.set_bus_volume_db(music_bus, linear_to_db(value)),
		1.0, 0.0, 2.0
	)

	# 4. Wait for the 3-second goodbye
	await get_tree().create_timer(3.0).timeout
	
	# 5. Finally close the game
	get_tree().quit()

func _on_back_options_pressed() -> void:
	settings_panel.visible = false
	main_menu_buttons.visible = true
