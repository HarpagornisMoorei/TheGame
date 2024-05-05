extends CharacterBody3D

@onready var armature = $Armature
@onready var spring_arm_pivot = $SpringArmPivot
@onready var spring_arm = $SpringArmPivot/SpringArm3D
@onready var camera = get_node("SpringArmPivot/SpringArm3D/Camera3D4")
@onready var last_camera_current_state = false
@onready var anim_tree = $AnimationTree

const SPEED = 2.0
const JUMP_VELOCITY = 4.5
const LERP_VAL = 0.15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Initialize the last known state of the camera
	last_camera_current_state = camera.current
	# Set the initial mouse mode based on the camera's current state
	_update_mouse_mode(camera.current)

func _process(delta):
	if camera.current != last_camera_current_state:
		# There was a change in the camera's current state
		_update_mouse_mode(camera.current)
		last_camera_current_state = camera.current

func _update_mouse_mode(is_current: bool):
	if is_current:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		spring_arm_pivot.rotate_y(-event.relative.x * 0.005)
		spring_arm.rotate_x(-event.relative.y * 0.005)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI / 4, PI / 4)

func _physics_process(delta):
	# Apply gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump if the jump button is pressed and the character is on the floor
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Calculate input direction from the camera's perspective
	var input_dir = Vector3()
	if Input.get_action_strength("ui_up"):
		input_dir -= camera.global_transform.basis.z
	if Input.get_action_strength("ui_down"):
		input_dir += camera.global_transform.basis.z
	if Input.get_action_strength("ui_right"):
		input_dir += camera.global_transform.basis.x
	if Input.get_action_strength("ui_left"):
		input_dir -= camera.global_transform.basis.x

	# Normalize the input direction to maintain consistent movement speed
	input_dir.y = 0  # Ignore any vertical movement from camera tilt
	input_dir = input_dir.normalized()

	# Update horizontal movement based on the direction vector and speed
	if input_dir.length() > 0:
		velocity.x = input_dir.x * SPEED
		velocity.z = input_dir.z * SPEED

		# Rotate the character to face the direction of movement
		var target_rotation = atan2(-input_dir.x, -input_dir.z)
		armature.rotation.y = lerp_angle(armature.rotation.y, target_rotation, LERP_VAL)
	else:
		# Decelerate to stop when no input is detected
		velocity.x = 0
		velocity.z = 0

	# Use move_and_slide to handle collisions and sliding along surfaces
	move_and_slide()

	# Optionally update animation blend position based on speed
	anim_tree.set("parameters/BlendSpace1D/blend_position", velocity.length() / SPEED)
