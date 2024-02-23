extends Button

# Define the signal
signal close_panel_requested

func _ready():
	pressed.connect(_on_Button_pressed)

func _on_Button_pressed():
	# Emit the signal when the button is pressed
	emit_signal("close_panel_requested")
