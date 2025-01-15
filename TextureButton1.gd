extends TextureButton

# Use this for instance-specific initialization
var _initialized = false

# Static variable to manage button state across instances
static var button_state = 1  # Default to active (visible)

# Signal for communication
signal scene_transition_requested(scene_name: String)

func _ready():
	if not _initialized:
		call_deferred("connect_toggle_signal")
		_initialized = true
	
	# Connect press event only once
	if not pressed.is_connected(_on_button_pressed):
		pressed.connect(_on_button_pressed)
	
	# Initialize button state based on central control; use static variable for initial state
	update_visibility_from_state()

func connect_toggle_signal():
	if CentralScript and CentralScript.toggle_signal:
		if not CentralScript.toggle_signal.is_connected(_on_toggle_signal):
			var result = CentralScript.toggle_signal.connect(_on_toggle_signal)
			if result == OK:
				print("Button connected to toggle signals")
				print("Button initialized with central control")
			else:
				push_error("Failed to connect to toggle_signal")
	else:
		push_error("CentralScript or toggle_signal not available")

func _on_toggle_signal(target: String, state: int):
	print("Received toggle_signal with target:", target, " and state:", state)
	if target == "b":  # Only handle 'b' signals for this button
		button_state = state  # Update the static state
		update_visibility_from_state()

func _on_button_pressed():
	# Check if the button should be active based on the static variable
	if button_state == 0:
		print("Button is inactive, ignoring press.")
		return
	
	print("Play pressed")
	update_visibility_from_state(0)  # Hide buttons before scene change
	
	# Send signals before changing scene
	CentralScript.process_signal("d1 to1 h1 b0 m1 n1 c1 g1")
	SceneManager.process_signal("5 spawn")
	
	# Emit custom signal for scene transition
	emit_signal("scene_transition_requested", "node_2d - Copy")
	
	call_deferred("switch_camera")

func switch_camera():
	if not is_inside_tree():
		push_error("This node is not in the scene tree!")
		return
	
	if get_tree():
		# Use a small timer to delay the camera switch
		await get_tree().create_timer(0.01).timeout
		
		var camera_node = get_node_or_null("/root/node_2d - Copy/char/SpringArmPivot/SpringArm3D/Camera3D4")
		if camera_node:
			camera_node.make_current()
		else:
			push_error("Camera not found in new scene!")
	else:
		push_error("get_tree() returned null. Scene transition might have failed.")

	update_visibility_from_state(0)  # Ensure buttons remain hidden after camera switch

func update_visibility_from_state(state = -1):
	print("Updating button visibility based on static state")
	var parent = get_parent()
	if not parent:
		push_error("Parent node not found!")
		return
	
	var button_names = ["TextureButton2", "TextureButton3", "TextureButton"]
	var active_state = button_state if state == -1 else state  # Use state if provided, otherwise use static variable
	
	for button_name in button_names:
		var button = parent.get_node_or_null(button_name)
		if button:
			var active = active_state == 1  # 1 means active, 0 means inactive
			button.visible = active
			if button == self:
				self.disabled = !active
				print("This button visibility set to:", self.visible, "disabled set to:", !active)
		else:
			push_warning("Button not found: " + button_name)

func is_button_active():
	return button_state == 1  # Check if the static state is active
