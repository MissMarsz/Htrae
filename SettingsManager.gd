extends Node

const SAVE_PATH = "user://settings.cfg"
var config = ConfigFile.new()

func _ready():
	load_settings()

func save_setting(section: String, key: String, value: Variant):
	config.set_value(section, key, value)
	config.save(SAVE_PATH)

func get_setting(section: String, key: String, default: Variant):
	return config.get_value(section, key, default)

func load_settings():
	var err = config.load(SAVE_PATH)
	if err != OK:
		return # No save file yet, use defaults
	
	# Load audio levels specifically
	for bus_name in ["Master", "Music", "SFX"]:
		if config.has_section_key("audio", bus_name):
			var vol = config.get_value("audio", bus_name)
			var bus_id = AudioServer.get_bus_index(bus_name)
			if bus_id != -1:
				AudioServer.set_bus_volume_db(bus_id, linear_to_db(vol))
