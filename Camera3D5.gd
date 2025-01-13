extends Node

# Ready function to connect the signal when the scene is initialized
func _ready():
	var emitter_node = get_node("/root/Node")  # Make sure this path is correct
	if emitter_node:
		# Connect the signal dynamically
		emitter_node.dynamic_signal.connect(_on_dynamic_signal)
	else:
		print("Error: Emitter node not found!")

# This function will be called when the signal is emitted
func _on_dynamic_signal(target: String, value: int, location: String):
	print("Received signal with target:", target, ", value:", value, ", location:", location)
