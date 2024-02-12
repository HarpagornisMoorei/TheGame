extends Node

func _process(delta):
	if Input.is_action_just_pressed("emit_alert"):
		GlobalSignals.alert_message.emit(1)  # Emit an alert with ID 1
