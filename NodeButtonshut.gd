extends Node

func _ready():
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		if button is TextureButton:
			# Connect the 'messageclose' signal to the '_on_messageclose' method
			# The correct way to connect signals in Godot, ensuring to use the button as the emitter
			_on_messageclose()messageClose.button.connect(_on_messageclose, [button])

func _on_messageclose(button_emitter):
	# This method is called when 'messageclose' is emitted by any TextureButton
	print(button_emitter.name, " triggered messageclose")
	# Optionally, hide all TextureButtons except the one that emitted the signal
	_hide_other_buttons(button_emitter)

func _hide_other_buttons(except_button):
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		if button is TextureButton and button != except_button:
			button.visible = false
