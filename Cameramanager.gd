extends CharacterBody3D

@onready var armature = $Armature
@onready var spring_arm_pivot = $SpringArmPivot
@onready var spring_arm = $SpringArmPivot/SpringArm3D
@onready var camera = get_node("SpringArmPivot/SpringArm3D/Camera3D4")
@onready var last_camera_current_state = false
@onready var anim_tree = $AnimationTree

const SPEED = 1.0
const JUMP_VELOCITY = 4.5
const LERP_VAL = 0.15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Initialize the last known state
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
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction
	var input_dir = Vector3()
	

	# Forward and backward movement
	input_dir += -camera.transform.basis.z * Input.get_action_strength("ui_up")
	input_dir += camera.transform.basis.z * Input.get_action_strength("ui_down")

	# Left and right movement (perpendicular to the camera's forward direction)
	var camera_right = camera.transform.basis.x
	var camera_left = -camera_right
	input_dir += camera_right * Input.get_action_strength("ui_right")
	input_dir += camera_left * Input.get_action_strength("ui_left")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm_pivot.rotation.y)

	# Normalize the input direction to prevent faster movement in diagonal directions
	input_dir = input_dir.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		

	# Handle the movement
	velocity = input_dir * SPEED

	# Handle the direction
	if input_dir != Vector3.ZERO:
		armature.rotation.y = lerp_angle(armature.rotation.y, atan2(-velocity.x, -velocity.z), LERP_VAL)
	

	anim_tree.set("parameters/BlendSpace1D/blend_position", velocity.length() / SPEED)
	move_and_slide()
