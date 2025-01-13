extends Node

func _ready():
	var emitter = get_node("../Node2")  # Assuming sibling node
	if emitter:
		emitter.connect("toggle_signal", Callable(self, "_on_toggle"))
		print("Connected to toggle signals")

func _on_toggle(target: String, state: int):
	if target == "d":  # Only handle signals for this component
		print("Processing toggle - state:", state)
		if state == 1:
			print("Turning on")
			# Add turn on logic
		else:
			print("Turning off")
			# Add turn off logic
