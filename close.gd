extends TextureButton

# Signal to notify when the close button is pressed
signal close_all_apps

func _ready():
	pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed():
	# Emit a signal to close all apps
	emit_signal("close_all_apps")
