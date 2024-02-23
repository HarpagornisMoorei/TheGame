# Script for Close button (TextureButton)
extends TextureButton

signal close_panel_erequested

func _ready():
	pressed.connect(_on_Button_pressed)

func _on_Button_pressed():
	# Emit a signal when the button is pressed
	emit_signal("close_panel_erequested")
