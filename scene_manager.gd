extends Node

# Signal to notify about scene changes
signal scene_changed(new_scene: String)

func _ready():
	# Ensure this script is set as an autoload for global access
	_connect_scene_change()

# Function to process signals and handle scene changes
func process_signal(signal_str: String):
	print("SceneManager received signal:", signal_str)
	var commands = signal_str.split(" ")
	
	for command in commands:
		if command == "0":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://node_2d.tscn"
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "1":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://pride_ring.tscn"
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "1.1":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://imp_city.tscn"
			
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "2":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://wrath_ring.tscn"
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "3":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://gluttony_ring.tscn"
			print("transfered to gluttony ring")
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "4":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://greed_ring.tscn"
			print("transfered to greed ring")
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "5":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://lust_ring.tscn"
			print("transfered to lust ring")
			var error = get_tree().change_scene_to_file(scene_path)
		if command == "7":
			await get_tree().create_timer(2.0).timeout
			var scene_path = "res://sloth_ring.tscn"
			print("transfered to sloth_ring")
			var error = get_tree().change_scene_to_file(scene_path)

# Function to handle post-scene change logic
func _on_scene_loaded(new_scene):
	print("Scene loaded, ready to process signals for:", new_scene)
	# Add any logic here that should run after the scene has fully loaded

# Connect this function to the scene_changed signal
func _connect_scene_change():
	if not scene_changed.is_connected(Callable(self, "_on_scene_loaded")):
		scene_changed.connect(Callable(self, "_on_scene_loaded"))
