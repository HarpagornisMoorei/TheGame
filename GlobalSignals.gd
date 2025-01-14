extends Node

signal button_pressed_signal


# Declare the signal
signal alert_message(id)

# Assuming this script is attached to a node that manages or has access to Camera3D4

func hi():
	emit_signal("button_pressed_signal")
	var camera3D4 = get_node("SpringArmPivot/SpringArm3D/Camera3D4")
	var texture_button = get_node("Root/menu/TextureButton")
	
	if camera3D4:
		camera3D4.current = true
		texture_button.button_pressed_signal.connect(hi)
