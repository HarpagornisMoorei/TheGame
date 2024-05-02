# Attached to Camera3D
extends Camera3D
func process(delta):
	if self.current == true:
		print("ho")
		self.current = false
		get_node("/root/Node2D/TextureButton").button_pressed_signal.connect(close)
func close():
	self.current = false
