extends Panel

func _ready():
	# Ensure that the Panel can react to GUI inputs.
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	z_index = -1
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Assuming Panel2 is the direct parent
		var panel2 = get_parent()
		if panel2:
			panel2.hide()  # Hide Panel2
		# Since we're in _gui_input, the event is already considered handled for GUI purposes
# Assuming this script is attached to the Panel node


