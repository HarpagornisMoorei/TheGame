# SignalManager.gd
extends Node

# Define signals
signal hide_all_buttons
signal update_money(amout)
# Method to emit the signal to hide all buttons
func emit_hide_all_buttons():
	emit_signal("hide_all_buttons")

# Method to emit the signal with an amount to update money
func emit_update_money(amount: int):
	emit_signal("update_money", amount)
