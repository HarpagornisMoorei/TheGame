extends TextureButton

var button_active = true  # Changed to true for b1 default state
@onready var camera3D4_path = "../Node3D/Camera3D2"

func _ready():
	# Connect to the emitter's toggle signal
	var emitter = get_node("/root/Node2D/Node2")  # Adjust path as needed
	if emitter:
		if not emitter.toggle_signal.is_connected(_on_toggle_signal):
			emitter.toggle_signal.connect(_on_toggle_signal)
			print("Button connected to toggle signals")
			print("Button initialized in active state (b1)")
	else:
		print("Failed to find emitter node")
	
	# Connect press event
	pressed.connect(_on_button_pressed)
	
	# Initialize button state - now visible by default
	self.visible = true
	update_buttons_visibility(true)

func _on_toggle_signal(target: String, state: int):
	if target == "b":  # Only handle 'b' signals
		if state == 0:
			button_active = false
			update_buttons_visibility(false)
			print("Button deactivated")
		elif state == 1:
			button_active = true
			update_buttons_visibility(true)
			print("Button activated")

func _on_button_pressed():
	if not button_active:
		return
		
	print("Play pressed")
	
	# Get the emitter to send signals
	var emitter = get_node("/root/Node2D/Node2")
	if emitter:
		emitter.process_signal("d0 to1 h1 b0 m1 n1 c1")
	else:
		print("Emitter not found!")
	
	# Hide buttons and switch camera
	update_buttons_visibility(false)
	var camera_node = get_node("/root/gluttony_ring/char/SpringArmPivot/SpringArm3D/Camera3D4")
	if camera_node:
		camera_node.current = true

func update_buttons_visibility(should_be_visible: bool):
	# Update visibility for all related buttons
	var button_names = ["TextureButton2", "TextureButton3", "TextureButton"]
	var parent = get_parent()
	
	for button_name in button_names:
		var button = parent.get_node_or_null(button_name)
		if button:
			button.visible = should_be_visible && button_active
