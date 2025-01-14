extends TextureButton

# Timer to reduce the frequency of checks for the active camera
var check_timer = Timer.new()

func _ready():
	# Initially, the button is not visible
	visible = false
	# Connect the button's pressed signal
	pressed.connect(_on_TextureButton4_pressed)
	# Setup and start the timer
	check_timer.wait_time = 0.5  # Check every 0.5 seconds
	check_timer.autostart = true
	check_timer.connect("timeout", _on_check_timer_timeout)
	add_child(check_timer)

func _on_check_timer_timeout():
	var camera3D2 = get_node("/root/Node2D/Node3D/Camera3D2")
	
	# Check if Camera3D3 is the active camera
	if camera3D2.current:
		visible = true
	else:
		visible = false

func _on_TextureButton4_pressed():
	# Switch active camera back to Camera3D2
	var camera3D2 = get_node("/root/Node2D/Node3D/Camera3D2")
	
	if camera3D2:
		camera3D2.current = true
		
	# Optionally hide the button after pressing
	visible = false
