extends HSlider

@export var audio_bus_name: String
var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	
	# 1. Get the actual volume currently set in the engine
	var current_db = AudioServer.get_bus_volume_db(audio_bus_id)
	
	# 2. Convert that DB value back to a 0.0 - 1.0 value for the slider
	# and set the slider's position to match
	self.value = db_to_linear(current_db)

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
