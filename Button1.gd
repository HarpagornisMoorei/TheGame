# Button1.gd - Attached to a Button node in Godot 4.2
extends Button

func _ready():
	pressed.connect(_on_Button_pressed)

func _on_Button_pressed():
	GlobalSignals.alert_message.emit(2)
