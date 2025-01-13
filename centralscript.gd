extends Node

# Signal for component toggles
signal toggle_signal(target, state)

# Process incoming signal string (like "abc0 def1 xyz1")
func process_signal(signal_str: String):
	print("Received signal:", signal_str)
	
	# Split the string into individual commands
	var commands = signal_str.split(" ")
	
	# Process each command
	for command in commands:
		# Check if command ends with 0 or 1 and has at least one letter before it
		if command.length() >= 2 and (command.ends_with("0") or command.ends_with("1")):
			var target = command.substr(0, command.length() - 1)  # All characters except last
			var state = int(command[-1])  # Last character as state
			
			print("Toggle - target:", target, ", state:", state)
			emit_signal("toggle_signal", target, state)
		else:
			print("Invalid command (must end with 0 or 1):", command)

# Test the signal processor
func _ready():
	# Example usage
	process_signal("abc0 def1 xyz1")
