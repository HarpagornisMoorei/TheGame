extends Node

signal toggle_signal(target: String, state: int)

func _ready():
	# Just for testing
	emit_signal("toggle_signal", "b", 1)

func process_signal(signal_str: String):
	print("CentralScript received signal:", signal_str)
	
	var commands = signal_str.split(" ")
	
	for command in commands:
		if command.length() >= 2 and (command.ends_with("0") or command.ends_with("1")):
			var target = command.substr(0, command.length() - 1)
			var state = int(command[-1])
			
			print("CentralScript toggle - target:", target, ", state:", state)
			emit_signal("toggle_signal", target, state)
		else:
			print("CentralScript invalid command:", command)
