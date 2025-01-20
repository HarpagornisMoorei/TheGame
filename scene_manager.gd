extends Node

signal scene_changed(new_scene: String)
signal spawn_signal(scene_name: String, spawn_id: String)
signal camera_signal(scene_name: String, camera_id: String)

var current_scene_path: String = ""
var loading_screen_scene = preload("res://loading_screen.tscn")

func _ready():
	_connect_scene_change()

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
					_delay_spawn_signal(command)
				elif "camera" in command:
					_delay_camera_signal(command)
				else:
					emit_signal("spawn_signal", current_scene_path, command)
					print("Emitted signal: ", current_scene_path, " ", command)

func _change_scene(new_scene_path: String, message: String = ""):
	# Create and show loading screen
	var loading_screen = loading_screen_scene.instantiate()
	get_tree().root.add_child(loading_screen)
	loading_screen.start_loading(new_scene_path)
	
	# Update current scene path
	current_scene_path = new_scene_path
	
	# Emit signals and show message
	emit_signal("scene_changed", current_scene_path)
	if message != "":
		print(message)

func _on_scene_loaded(new_scene: String):
	print("Scene loaded, ready to process signals for:", new_scene)

func _connect_scene_change():
	if not scene_changed.is_connected(Callable(self, "_on_scene_loaded")):
		scene_changed.connect(Callable(self, "_on_scene_loaded"))

func _delay_spawn_signal(command: String):
	await get_tree().create_timer(0).timeout
	emit_signal("spawn_signal", current_scene_path, command)
	print("Emitted spawn signal with delay: ", current_scene_path, " ", command)

func _delay_camera_signal(command: String):
	await get_tree().create_timer(0).timeout
	emit_signal("camera_signal", current_scene_path, command)
	print("Emitted camera signal with delay: ", current_scene_path, " ", command)
