extends Camera3D

func _ready():
	self.current = true  # Ensure this camera is active at start
	print("Camera3D is being activated.")
	CameraSignals.activate_game_camera()
	print("Signal for Camera3D activation sent.")
