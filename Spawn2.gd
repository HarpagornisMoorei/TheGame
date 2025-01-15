extends MeshInstance3D

@export var spawn_id: String = "spawn4"  # Listening for the specific "3 spawn" ID

func _ready():
	# Connect to SceneManager's spawn signal
	if not SceneManager.spawn_signal.is_connected(self._on_spawn_signal):
		SceneManager.spawn_signal.connect(self._on_spawn_signal)
		print("Connected to spawn signal with spawn_id: ", spawn_id)

func _on_spawn_signal(scene_name: String, spawn_id: String):
	# Print if the instance is of type MeshInstance3D
	if is_instance_valid(self) and self is MeshInstance3D:
		print("Received spawn signal in MeshInstance3D with spawn_id:", spawn_id)

	# Check if this spawn point should activate for "3 spawn"
	if spawn_id == self.spawn_id:
		print("Received and matched spawn signal for spawn_id: ", spawn_id)
		move_character_to_spawn()
	else:
		print("Received spawn signal but spawn_id did not match. Current: ", self.spawn_id, ", Received: ", spawn_id)

func move_character_to_spawn():
	# Example of moving the character, assuming it's correctly located
	var character = get_node("/root/Gluttony ring/char")
	if character:
		character.global_position = global_position
		print("Moved character to position: ", global_position)
	else:
		print("Warning: Character node not found!")
