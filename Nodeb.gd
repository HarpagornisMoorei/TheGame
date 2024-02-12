extends Node

func _process(delta):
	if Input.is_action_just_pressed("emit_alert_3"):
		GlobalSignals.emit_signal("alert_message", 3)  # Emit an alert with ID 3
