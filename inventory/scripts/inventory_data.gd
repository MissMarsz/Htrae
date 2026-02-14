class_name InventoryData extends Resource

# This holds the actual items
@export var inventory_slots: Array[SlotData] = []

# Helper to find if we have an item
func get_slot_at(index: int) -> SlotData:
	if index >= 0 and index < inventory_slots.size():
		return inventory_slots[index]
	return null
