extends Node

	#not being used yet needs work

var custom_cursor_texture : Texture2D
var hotbar_items := []

func _ready():
	if custom_cursor_texture:
		update_cursor(custom_cursor_texture)
		
func update_cursor(texture: Texture2D):
	if texture:
		Input.set_custom_mouse_cursor(texture,Input.CURSOR_ARROW)
	else:
		Input.set_custom_mouse_cursor(null)
