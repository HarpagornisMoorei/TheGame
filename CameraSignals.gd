extends Node

# Define signals
signal camera_game_active
signal camera_menu_active

# Function to emit signal for Camera3D
func activate_game_camera():
	emit_signal("camera_game_active")

# Function to emit signal for Camera3D2
func activate_menu_camera():
	emit_signal("camera_menu_active")
