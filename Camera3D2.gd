extends Camera3D

# Define rotation speed in degrees per second and the radius for the rotation
var rotation_speed = 5.0  # Adjust this value to control the rotation speed
var radius = 0.1  # Adjust the distance of the camera from the point it rotates around
var custom_rotation_degrees = 0.0  # Custom variable to track the rotation to avoid conflict with Camera3D's property

func _ready():
	self.current = true  # Ensure this camera is active at start
	print("Camera3D2 is being activated.")
	CameraSignals.activate_menu_camera()
	print("Signal for Camera3D2 activation sent.")

func _process(delta):
	# Update the total custom rotation based on the rotation speed and the frame's delta time
	custom_rotation_degrees += rotation_speed * delta
	# Ensure custom_rotation_degrees stays within 0-360 to prevent precision loss over time
	custom_rotation_degrees = fmod(custom_rotation_degrees, 360.0)
	
	# Calculate the new position based on the updated rotation
	var radians = deg_to_rad(custom_rotation_degrees)
	var new_x = radius * sin(radians)
	var new_z = radius * cos(radians)
	
	# Update the camera's position
	global_transform.origin.x = new_x
	global_transform.origin.z = new_z
	
	# Ensure the camera still looks at the center point after moving
	look_at(Vector3.ZERO, Vector3.UP)
