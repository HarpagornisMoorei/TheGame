extends Camera3D  # Or Camera2D depending on your setup

@export var camera_id: String = "camera1"  # Set this in the editor

func _ready():
	# Connect to the camera signal
	if not SceneManager.camera_signal.is_connected(_on_camera_signal):
		SceneManager.camera_signal.connect(_on_camera_signal)

func _on_camera_signal(scene_name: String, cam_id: String):
	if cam_id == camera_id:
		# Activate this camera and deactivate others
		make_current()
		print("Camera ", camera_id, " activated")
