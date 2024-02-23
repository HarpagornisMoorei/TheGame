extends TextureRect

func _ready():
	# Direct reference to the CloseButton node might require fetching the node in a way that's type-safe or using a known path
	var close_button = get_parent().get_node("close") # Adjust based on actual scene structure

	# Connect without using strings for signal and method names, assuming Godot supports this syntax
	close_button.close_panel_erequested.connect(_on_close_panel_erequested)

func _on_close_panel_erequested():
	visible = false # Hide this panel
