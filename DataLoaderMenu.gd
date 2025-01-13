extends Node

# Current active slot
var current_slot = 1

# Save paths for different data types
func get_save_path(data_type: String) -> String:
	return "user://slot" + str(current_slot) + "_" + data_type + ".save"

# Switch active save slot
func switch_slot(slot_number: int):
	if slot_number >= 1 and slot_number <= 3:
		current_slot = slot_number
		print("Switched to save slot:", slot_number)
		load_all_data()

# Save data to current slot
func save_data(data_type: String, data: Dictionary):
	var file = FileAccess.open(get_save_path(data_type), FileAccess.WRITE)
	if file:
		file.store_var(data)
		print("Saved " + data_type + " data to slot", current_slot)

# Load data from current slot
func load_data(data_type: String) -> Dictionary:
	if FileAccess.file_exists(get_save_path(data_type)):
		var file = FileAccess.open(get_save_path(data_type), FileAccess.READ)
		if file:
			var data = file.get_var()
			print("Loaded " + data_type + " data from slot", current_slot)
			return data
	return {}

# Delete a specific slot
func delete_slot(slot_number: int):
	var data_types = ["weapons", "spawns", "player", "quests"]
	for type in data_types:
		var path = "user://slot" + str(slot_number) + "_" + type + ".save"
		if FileAccess.file_exists(path):
			DirAccess.remove_absolute(path)
	print("Deleted all data for slot", slot_number)

# Load all data for current slot
func load_all_data():
	weapons_data = load_data("weapons")
	spawn_data = load_data("spawns")
	player_data = load_data("player")
	quest_data = load_data("quests")

# Data dictionaries for different systems
var weapons_data = {}
var spawn_data = {}
var player_data = {}
var quest_data = {}

# Weapon system functions
func save_weapon(weapon_id: String, state: int):
	weapons_data[weapon_id] = state
	save_data("weapons", weapons_data)

func get_weapon_state(weapon_id: String) -> int:
	return weapons_data.get(weapon_id, 0)

# Spawn system functions
func save_spawn(spawn_id: String, state: int):
	spawn_data[spawn_id] = state
	save_data("spawns", spawn_data)

func get_spawn_state(spawn_id: String) -> int:
	return spawn_data.get(spawn_id, 0)

# Example player data functions
func save_player_state(state_data: Dictionary):
	player_data = state_data
	save_data("player", player_data)

func get_player_state() -> Dictionary:
	return player_data

# Initialize
func _ready():
	load_all_data()
