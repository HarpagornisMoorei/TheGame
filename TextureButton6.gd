extends TextureButton
@onready var camera3D4 = get_node("../Node3D/Camera3D2")
# Define a custom signal for when the button is pressed
signal button_pressed_signal

var camera3D2_path = "../Node3D/Camera3D2"
var buttons_visibility_dependent_on_camera3D2 = true

func _ready():
	pressed.connect(_on_PlayButton_pressed)
	# Optionally, initialize button visibility based on the current state.
	update_buttons_visibility_based_on_camera3D2()

func _process(delta):
	self.visible = true
	if buttons_visibility_dependent_on_camera3D2:
		update_buttons_visibility_based_on_camera3D2()

func _on_PlayButton_pressed():
	var camera
	print("Play pressedd")
	
	print("button_pressed_signal emitted")
	 # If you also want to deactivate Camera3D4, you would do it like this:
	
	
		
	toggle_camera3D2()

func toggle_camera3D2():
	var camera3D2 = get_node_or_null(camera3D2_path)
	if camera3D2:
		camera3D2.current = !camera3D2.current
		print("Camera3D2 toggled, now active: " + str(camera3D2.current))

func update_buttons_visibility_based_on_camera3D2():
	var camera3D2 = get_node_or_null(camera3D2_path)
	var should_show_buttons = camera3D2 && camera3D2.current
	set_buttons_visibility(should_show_buttons)

func set_buttons_visibility(should_be_visible):
	var button_names = ["TextureButton2", "TextureButton3", "TextureButton, TextureButton6"]
	var parent = get_parent()
	for button_name in button_names:
		var button = parent.get_node_or_null(button_name)
		if button:
			button.visible = should_be_visible
