# SignalManager.gd
extends Node

# Define the signal
signal hide_all_buttons

# Method to call to emit the signal to hide all buttons
func emit_hide_all_buttons():
	emit_signal("hide_all_buttons")
