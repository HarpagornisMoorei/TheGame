# ButtonsContainer.gd
extends Control  # Changed from Node to Control

func _ready():
	SignalManager.connect("hide_all_buttons", Callable(self, "hide_all_buttons"))
	
	# Direct reference to the CloseButton node might require fetching the node in a way that's type-safe or using a known path
	var close_button = get_parent().get_node("close") # Adjust based on actual scene structure

	# Connect without using strings for signal and method names, assuming Godot supports this syntax
	close_button.close_panel_erequested.connect(_on_close_panel_erequested)

func _on_close_panel_erequested():
	visible = true # Hide this panel
	print('hi')

func hide_all_buttons():
	visible = false  # Now valid because Control nodes have a 'visible' property

func show_buttons():
	visible = true  # Also valid for the same reason
	

