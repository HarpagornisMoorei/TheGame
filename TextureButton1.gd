extends TextureButton

# Button state
static var button_active = true

# Signal for communication
signal scene_transition_requested(scene_name: String)

# Use this to check if _ready has already been called once
var initialized = false

func _ready():
	if not initialized:
		call_deferred("connect_toggle_signal")
		initialized = true
	
	# Connect press event only once
	if not pressed.is_connected(_on_button_pressed):
		pressed.connect(_on_button_pressed)
	
	# Initialize button state
	self.visible = true
	update_buttons_visibility(true)

func connect_toggle_signal():
	if CentralScript and CentralScript.toggle_signal:
		if not CentralScript.toggle_signal.is_connected(_on_toggle_signal):
			var result = CentralScript.toggle_signal.connect(_on_toggle_signal)
			if result == OK:
				print("Button connected to toggle signals")
				print("Button initialized in active state (b1)")
			else:
				push_error("Failed to connect to toggle_signal")
	else:
		push_error("CentralScript or toggle_signal not available")

func _on_toggle_signal(target: String, state: int):
	print("Received toggle_signal with target:", target, " and state:", state)
	if target == "b":  # Only handle 'b' signals
		button_active = (state == 1)
		update_buttons_visibility(button_active)
		print("Button " + ("activated" if button_active else "deactivated"))

func _on_button_pressed():
	print("Button pressed with active state: ", button_active)
	if not button_active:
		print("Button is inactive, ignoring press.")
		return
	
	print("Play pressed")
	
	# Update visibility of buttons before the scene transition
	update_buttons_visibility(false)
	
	# Send signals before changing scene
	CentralScript.process_signal("d1 to1 h1 b0 m1 n1 c1 g1")
	SceneManager.process_signal("3")
	
	# Emit custom signal for scene transition
	emit_signal("scene_transition_requested", "node_2d - Copy")
	
	# Hide buttons before scene change
	update_buttons_visibility(false)

	# Schedule camera switch for next frame to ensure scene is loaded
	call_deferred("switch_camera")

func switch_camera():
	if not is_inside_tree():
		push_error("This node is not in the scene tree!")
		return
	
	if get_tree():
		# Use a small timer to delay the camera switch
		await get_tree().create_timer(0.01).timeout
		
		# Try to find camera in new scene
		var camera_node = get_node_or_null("/root/node_2d - Copy/char/SpringArmPivot/SpringArm3D/Camera3D4")
		if camera_node:
			camera_node.make_current()
		else:
			push_error("Camera not found in new scene!")
	else:
		push_error("get_tree() returned null. Scene transition might have failed.")

	# In the new scene, hide the button again to ensure it's not visible
	update_buttons_visibility(false)

func update_buttons_visibility(should_be_visible: bool):
	print("Update called with should_be_visible:", should_be_visible, "button_active:", button_active)
	var parent = get_parent()
	if not parent:
		push_error("Parent node not found!")
		return
	
	var button_names = ["TextureButton2", "TextureButton3", "TextureButton"]
	
	for button_name in button_names:
		var button = parent.get_node_or_null(button_name)
		if button:
			# Ensure visibility is updated properly before the transition
			button.visible = should_be_visible and button_active
			if button == self:  # Ensure this script's button reflects the correct state
				self.disabled = !button_active  # Disable button if not active
				print("This button visibility set to:", self.visible, "disabled set to:", self.disabled)
		else:
			push_warning("Button not found: " + button_name)
