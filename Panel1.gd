extends Panel

var camera3D
var camera3D2
var textureButton
var textureButton2
var textureButton3
var exitPrompt  # Changed from confirmDialog to exitPrompt for clarity

func _ready():
	camera3D = get_node("/root/Node2D/Node3D/Camera3D")
	camera3D2 = get_node("/root/Node2D/Node3D/Camera3D2")
	textureButton = get_node("/root/Node2D/TextureButton")
	textureButton2 = get_node("/root/Node2D/TextureButton2")
	textureButton3 = get_node("/root/Node2D/TextureButton3")
	exitPrompt = get_node("/root/Node2D/ExitPrompt")  # Make sure to add a Label node named ExitPrompt to your scene
	exitPrompt.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("toggle_item_menu") and camera3D.is_current():
		visible = !visible
	if Input.is_action_just_pressed("ui_cancel") and camera3D.is_current():
		# Only show the exit prompt when Camera3D is active (game view)
		exitPrompt.visible = true

	# Handle the exit prompt
	if exitPrompt.visible:
		if Input.is_action_just_pressed("confirm_exit"):  # 'Y' key to confirm
			go_to_start_screen()  # Call the function to go to the start screen
		elif Input.is_action_just_pressed("ui_back"):  # 'N' key to cancel
			exitPrompt.visible = false  # Hide the exit prompt without changing the screen


func go_to_start_screen():
	camera3D.current = false
	camera3D2.current = true
	visible = false
	textureButton.show()
	textureButton2.show()
	textureButton3.show()
	exitPrompt.visible = false  # Also hide the exit prompt
	# Other logic to return to the start screen or main menu
