extends Control

#func _ready():
	##$MarginContainer/VBoxContainer/NextButton.pressed.connect(_on_next_pressed)


func _on_next_pressed():
	print("Continue with selected character")
	get_tree().change_scene_to_file("res://Scenes/WorldSelect/WorldSelect.tscn")


func _on_create_new_pressed() -> void:
	# Later: open character creator scene
	print("Create new character clicked!")
	get_tree().change_scene_to_file("res://Scenes/character_creator.tscn")
