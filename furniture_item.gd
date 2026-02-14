extends StaticBody2D

# 0: South, 1: North, 2: East, 3: West
@export_enum("South", "North", "East", "West") var direction: int = 0:
	set(value):
		direction = value
		if is_inside_tree():
			_update_sprite()

@onready var sprite = $Sprite2D 

func _ready():
	_update_sprite()

func _update_sprite():
	# Assumes a horizontal spritesheet with 4 frames
	sprite.frame = direction

# Call this to cycle through directions
func rotate_furniture():
	# Loops 0, 1, 2, 3 and back to 0
	direction = (direction + 1) % 4
