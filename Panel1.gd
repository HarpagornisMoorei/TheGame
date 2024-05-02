extends Panel

var camera3D
var camera3D2
var textureButton
var textureButton2
var textureButton3
var exitPrompt  # Changed from confirmDialog to exitPrompt for clarity

func _ready():
	camera3D = get_node("../main/SpringArmPivot/SpringArm3D/Camera3D4")
	camera3D2 = get_node("/root/Node2D/Node3D/Camera3D2")
	textureButton = get_node("/root/Node2D/TextureButton")
	textureButton2 = get_node("/root/Node2D/TextureButton2")
	textureButton3 = get_node("/root/Node2D/TextureButton3")
	exitPrompt = get_node("/root/Node2D/ExitPrompt")
	exitPrompt.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("toggle_item_menu") and camera3D.is_current():
		visible = !visible

	if visible and Input.is_action_just_pressed("ui_cancel"):
		hide_gui()
	elif not visible and Input.is_action_just_pressed("ui_cancel") and camera3D.is_current():
		exitPrompt.visible = true

	if exitPrompt.visible:
		if Input.is_action_just_pressed("confirm_exit"):
			go_to_start_screen()
		elif Input.is_action_just_pressed("ui_back"):
			exitPrompt.visible = false

func hide_gui():
	visible = false
	exitPrompt.visible = false

func _gui_input(event):
	if visible and event is InputEventMouseButton and event.pressed and not event.is_echo():
		var global_rect = Rect2(global_position, size)
		if not global_rect.has_point(event.global_position):
			hide_gui()

func go_to_start_screen():
	camera3D.current = false
	camera3D2.current = true
	visible = false
	textureButton.show()
	textureButton2.show()
	textureButton3.show()
	exitPrompt.visible = false
