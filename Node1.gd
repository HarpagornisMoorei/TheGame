# ButtonsContainer.gd
extends Node

func _ready():
	SignalManager.connect("hide_buttons", Callable(self, "hide_all_buttons"))

func hide_all_buttons():
	visible = false  # Hide the container, which hides all child buttons

func show_buttons():
	visible = true  # Show the container, making all child buttons visible again
