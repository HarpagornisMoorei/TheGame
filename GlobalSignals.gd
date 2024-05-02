extends Node
signal alert_message(id)
signal button_pressed_signal
# Define the signal
# Assuming this script is attached to a node that manages or has access to Camera3D4


func hi():
	emit_signal("_on_buttom_pressed")
	var Camera3D4 = get_node("SpringArmPivot/SpringArm3D/Camera3D4")
	var _TextureButton = get_node("../TextureButton")
	if Camera3D4:
		Camera3D4.current = true
		_TextureButton.button_pressed_signal.connect(hi)
