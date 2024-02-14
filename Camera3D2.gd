extends Camera3D

# Define rotation speed in degrees per second and the radius for the rotation
var rotation_speed = 5.0
var radius = 5.0
var elevation_height = 2.0  # Directly set the camera's height above the rotation plane
var custom_rotation_degrees = 0.0

func _ready():
	self.current = true
	print("Camera3D2 is being activated.")

func _process(delta):
	custom_rotation_degrees += rotation_speed * delta
	custom_rotation_degrees = fmod(custom_rotation_degrees, 360.0)
	
	var radians = deg_to_rad(custom_rotation_degrees)
	var new_x = radius * sin(radians)
	var new_z = radius * cos(radians)
	# Set the camera's position, including elevation
	global_transform.origin.x = new_x
	global_transform.origin.z = new_z
	global_transform.origin.y = elevation_height

	# Target point adjustment: Ensure the camera looks towards a central point
	# This can be Vector3.ZERO or any other point you want the camera to focus on
	var target_point = Vector3.ZERO

	look_at(target_point, Vector3.UP)
