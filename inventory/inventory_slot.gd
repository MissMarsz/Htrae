class_name InventorySlot extends Control


var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


var item: ItemData = null
var slot_index = 0

signal item_clicked(index: int)
signal item_dragged(from_index: int, to_index: int)


func set_slot_data( value : SlotData ) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str( slot_data.quantity )
	
func update_slot(new_item: ItemData):
	item = new_item
	#texture_normal = item.texture if item else null

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			emit_signal("item_clicked", slot_index)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# right click = use, equip, etc.
			# (you'd implement that logic in the InventoryUI script)
			pass

func _can_drop_data(_pos, _data):
	return true

func _drop_data(pos, data):
	emit_signal("item_dragged", data["from_index"], slot_index)
