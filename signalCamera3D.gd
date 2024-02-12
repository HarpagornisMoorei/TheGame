extends Camera3D
signal camera_status_changed(isActive)

func _ready():
	# Emit signal when the camera becomes active
	if self.is_current():
		emit_signal("camera_status_changed", true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and self.is_current():
		emit_signal("camera_status_changed", true)
