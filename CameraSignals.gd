extends Node

# Define signals
signal camera_game_acti1ve
signal camera_menu_acti1ve

# Function to emit signal for Camera3D
func activate_game_camra():
	emit_signal("camera_game_acti1ve")

# Function to emit signal for Camera3D2
func activate_menu_camra():
	emit_signal("camera_menu_acti1ve")
