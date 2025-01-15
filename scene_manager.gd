extends Node

# Define signals for scene changes, spawn points, and cameras
signal scene_changed(new_scene: String)
signal spawn_signal(scene_name: String, spawn_id: String)
signal camera_signal(scene_name: String, camera_id: String)

# Variable to track the current scene path
var current_scene_path: String = ""

# Called when the node is added to the scene
func _ready():
	_connect_scene_change()

# Process input signals for scene management, spawning, and cameras
func process_signal(signal_str: String):
	print("SceneManager received signal:", signal_str)
	var commands = signal_str.split(" ")
	
	for command in commands:
		match command:
			"0":
				_change_scene("res://node_2d - Copy.tscn")
			"1":
				_change_scene("res://pride_ring.tscn")
			"1.1":
				_change_scene("res://imp_city.tscn")
			"2":
				_change_scene("res://wrath_ring.tscn")
			"3":
				_change_scene("res://gluttony_ring.tscn", "Transferred to gluttony ring")
			"4":
				_change_scene("res://greed_ring.tscn", "Transferred to greed ring")
			"5":
				_change_scene("res://lust_ring.tscn", "Transferred to lust ring")
			"7":
				_change_scene("res://sloth_ring.tscn", "Transferred to sloth ring")
			_:
				if "spawn" in command:
					# Add a delay before emitting the spawn signal
					_delay_spawn_signal(command)
				elif "camera" in command:
					# Handle camera signals with delay
					_delay_camera_signal(command)
				else:
					# Process other signals without delay
					emit_signal("spawn_signal", current_scene_path, command)
					print("Emitted signal: ", current_scene_path, " ", command)

# Change scene with error handling and optional message
func _change_scene(new_scene_path: String, message: String = ""):
	await get_tree().create_timer(2.0).timeout
	current_scene_path = new_scene_path
	var error = get_tree().change_scene_to_file(current_scene_path)
	if error != OK:
		print("Error changing scene to: ", new_scene_path, ", Error: ", error)
	else:
		emit_signal("scene_changed", current_scene_path)
		if message != "":
			print(message)

# Called when a new scene is loaded
func _on_scene_loaded(new_scene: String):
	print("Scene loaded, ready to process signals for:", new_scene)

# Connect the scene_changed signal to the handler
func _connect_scene_change():
	if not scene_changed.is_connected(Callable(self, "_on_scene_loaded")):
		scene_changed.connect(Callable(self, "_on_scene_loaded"))

# Delay before emitting the spawn signal
func _delay_spawn_signal(command: String):
	await get_tree().create_timer(6.0).timeout
	emit_signal("spawn_signal", current_scene_path, command)
	print("Emitted spawn signal with delay: ", current_scene_path, " ", command)

# Delay before emitting the camera signal
func _delay_camera_signal(command: String):
	await get_tree().create_timer(6.0).timeout
	emit_signal("camera_signal", current_scene_path, command)
	print("Emitted camera signal with delay: ", current_scene_path, " ", command)
