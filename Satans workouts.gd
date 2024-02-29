extends TextureButton

func _ready():
	# Connect the button press signal to the _on_EmailButton_pressed function
	pressed.connect(Callable(self, "_on_EmailButton_pressed"))

func _on_EmailButton_pressed():
	# Navigate up to "Panel2" and then find "EmailApp"
	var email_app_screen = get_node("../../Satans workouts")
	if email_app_screen:
		# If found, make the "EmailApp" visible
		email_app_screen.visible = true
	
	# Emit a signal to hide all buttons, assuming SignalManager has been properly set up
	SignalManager.emit_signal("hide_all_buttons")

func hide_this_button():
	# This function hides the button when the hide_all_buttons signal is emitted
	self.visible = false
