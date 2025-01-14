extends Camera3D

# Camera settings
var rotation_speed = 5.0
var radius = 5.0
var elevation_height = 2.0
var custom_rotation_degrees = 0.0
var camera_active = false  # Default to inactive (c0)

func _ready():
	# Connect to the emitter's toggle signal
	var emitter = get_node("CentralScript")  # Adjust path as needed
	if emitter:
		if not emitter.toggle_signal.is_connected(_on_toggle_signal):
			emitter.toggle_signal.connect(_on_toggle_signal)
			print("Camera connected to toggle signals")
			print("Camera initialized in disabled state (c0)")
	else:
		print("Failed to find emitter node")
	
	# Initialize camera state
	self.current = false
	self.visible = false
	print("Camera initialized")

func _on_toggle_signal(target: String, state: int):
	if target == "c":  # Only handle 'c' signals
		if state == 0:
			camera_active = false
			self.current = false
			self.visible = false
			print("Camera deactivated")
		elif state == 1:
			camera_active = true
			self.current = true
			self.visible = true
			print("Camera activated")

func _process(delta):
	if not camera_active:  # Only process when camera is active
		return
		
	custom_rotation_degrees += rotation_speed * delta
	custom_rotation_degrees = fmod(custom_rotation_degrees, 360.0)
	
	var radians = deg_to_rad(custom_rotation_degrees)
	var new_x = radius * sin(radians)
	var new_z = radius * cos(radians)
	
	# Set the camera's position, including elevation
	global_transform.origin.x = new_x
	global_transform.origin.z = new_z
	global_transform.origin.y = elevation_height
	
	# Look at center point
	look_at(Vector3.ZERO, Vector3.UP)
