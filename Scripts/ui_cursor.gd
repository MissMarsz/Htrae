extends CanvasLayer
	#UICursor needs work
	
@onready var cursor_sprite = $CursorSprite
var update_cursor
func _process(delta):
	global_position = get_viewport().get_mouse_position()
	
	func update_cursor(texture: Texture2D):
		cursor_sprite.texture = texture
