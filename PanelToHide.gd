extends Panel

func _ready():
	# Direct reference to the CloseButton node might require fetching the node in a way that's type-safe or using a known path
	var close_button = get_parent().get_node("CloseButton") # Adjust based on actual scene structure

	# Connect without using strings for signal and method names, assuming Godot supports this syntax
	close_button.close_panel_requested.connect(_on_close_panel_requested)

func _on_close_panel_requested():
	visible = false # Hide this panel
