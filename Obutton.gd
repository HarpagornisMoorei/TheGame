extends Node

signal alert_message(id)
signal button_pressed_signal

func _process(delta):
	if Input.is_action_just_pressed("emit_alert"):
		GlobalSignals.alert_message.emit(1)  # Emit an alert with ID 1
