extends Node

# Signal to notify about slot changes
signal slot_changed(slot_number: int)

func emit_slot_signal(slot: int):
	if slot >= 1 and slot <= 3:
		emit_signal("slot_changed", slot)
		print("SlotSignalManager emitted signal for slot: ", slot)
