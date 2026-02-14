extends Control

@export var data: InventoryData
@onready var grid := $Inventory/MainContainer/MarginContainer/GridContainer

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS # Crucial for pausing

func _input(event):
	if event.is_action_pressed("ui_inventory"): # The 'E' key
		toggle_inventory()

func toggle_inventory():
	visible = !visible
	get_tree().paused = visible # Pauses game world
	
	if visible:
		render_slots()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func render_slots():
	if not grid: return
	
	for child in grid.get_children():
		child.queue_free()
		
	for slot_data in data.inventory_slots:
		var slot = preload("res://inventory/inventory_slot.tscn").instantiate()
		grid.add_child(slot)
		if slot.has_method("set_slot_data"):
			slot.set_slot_data(slot_data)
