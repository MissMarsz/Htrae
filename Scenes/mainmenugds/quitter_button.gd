extends Button

@onready var sprite = $AnimatedSprite2D
@onready var label = $Label

func _ready():
	# Center the label over the button automatically
	label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	
	# Start on the first frame and stay still
	sprite.frame = 2
	sprite.stop()

func _on_pressed():
	# Play the animation from start to finish
	sprite.frame = 0
	sprite.play()
func _on_quitter_button_mouse_entered():
	var tween = create_tween()
	# Scale is now 1.05 (half the growth) and we use TRANS_CUBIC for a smoother feel
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func _on_quitter_button_mouse_exited():
	var tween = create_tween()
	# Return to normal scale smoothly
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_CUBIC)
