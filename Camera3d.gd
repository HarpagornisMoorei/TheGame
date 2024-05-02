extends Node # Or Node, Node2D, depending on your scene setup

# Define a custom signal for camera activation
signal camera_activated(camera_name)

func _ready():
	# Example of manually emitting a signal when a specific condition is met
	# In a real scenario, you'd call this under specific conditions
	emit_signal("camera_activated", "Camera3D")

func _on_camera_activated(camera_name: String):
	if camera_name == "Camera3D":
		# Perform the camera switch
		var camera3D4 = get_node_or_null("SpringArmPivot/SpringArm3D/Camera3D4")
		if camera3D4:
			camera3D4.make_current()
			print("Camera3D4 is now active.")
