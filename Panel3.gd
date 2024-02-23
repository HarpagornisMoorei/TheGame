extends Panel

func _ready():
	modulate = Color(1, 1, 1, 0)
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		# Assuming MainPanel is a sibling to this ClickDetectorPanel
		var main_panel = get_parent().get_node("MainPanel")
		if not main_panel.get_global_rect().has_point(event.global_position):
			main_panel.hide()  # Hide the main panel
