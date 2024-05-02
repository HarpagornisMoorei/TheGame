extends Camera3D

# Example custom signal (define your own based on needs)
signal camera_activated

func _ready():
	# Check if this camera is the current camera at startup
	if is_current():
		print("This camera is currently active.")
	else:
		print("This camera is not active.")
	
	# Connect to the custom signal (assuming you have defined it elsewhere in your script)
	
	# Example of emitting a custom signal
	# This is just an example, you'd typically emit signals based on specific events
	emit_signal("camera_activated")

func _on_camera_activated():
	print("The custom signal 'camera_activated' was emitted.")

# Example function to toggle the current state of the camera
func toggle_camera_active():
	self.current = !is_current()
	print("Camera active state toggled. Now active: ", is_current())
	# Emitting signal on toggle
	emit_signal("camera_activated")

# You can call toggle_camera_active() based on some game event or input to change the camera's active state
