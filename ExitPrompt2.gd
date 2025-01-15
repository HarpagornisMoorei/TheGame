extends Label

func _ready():
	# Ensure the input event is captured
	set_process_input(true)

func _input(event):
	# Check if the event is a key press and if the event is a valid InputEventKey
	if event is InputEventKey:
		# Now safely check the keycode if the event is a valid key press
		if event.pressed:
			# If 'Esc' is pressed, cancel the action (ui_cancel)
			if event.keycode == KEY_ESCAPE:
				print("Esc key pressed - UI Cancel")
				# Add action for UI Cancel here
			# If 'Y' is pressed, confirm exit (confirm_exit)
			elif event.keycode == KEY_Y:
				print("Y key pressed - Confirm Exit")
				SceneManager.process_signal("0 spawn3 camera1")
				CentralScript.process_signal("d1 to0 h0 b1 m0 n0 c1 g1")
			# If 'X' is pressed, go back (ui_back)
			elif event.keycode == KEY_X:
				print("X key pressed - UI Back")
				self.visible = false  # Example action for 'X'
