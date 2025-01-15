extends Node

var current_slot: int = 1
var base_path = "user://saves/"

func _ready():
	# Create all slot directories at startup
	for slot in range(1, 4):
		var slot_path = base_path + "slot" + str(slot) + "/"
		DirAccess.make_dir_recursive_absolute(slot_path)
	
	if not Slotsignalmanager.slot_changed.is_connected(_on_slot_changed):
		Slotsignalmanager.slot_changed.connect(_on_slot_changed)

func _on_slot_changed(slot: int):
	current_slot = slot
	print("SaveManager switched to slot: ", slot)

# Basic file operations
func write_data(filename: String, data: String):
	var slot_path = base_path + "slot" + str(current_slot) + "/"
	var file = FileAccess.open(slot_path + filename, FileAccess.WRITE)
	file.store_string(data)

func read_data(filename: String) -> String:
	var slot_path = base_path + "slot" + str(current_slot) + "/"
	var file_path = slot_path + filename
	if not FileAccess.file_exists(file_path):
		return ""
	var file = FileAccess.open(file_path, FileAccess.READ)
	return file.get_as_text()

# Delete specific file from current slot
func delete_file(filename: String) -> bool:
	var slot_path = base_path + "slot" + str(current_slot) + "/"
	var file_path = slot_path + filename
	if FileAccess.file_exists(file_path):
		var error = DirAccess.remove_absolute(file_path)
		print("Deleted file: ", filename, " from slot ", current_slot)
		return error == OK
	return false

# Delete all files in a specific slot
func delete_slot(slot_number: int) -> bool:
	var slot_path = base_path + "slot" + str(slot_number) + "/"
	var dir = DirAccess.open(slot_path)
	if dir:
		# Delete all files in the slot
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not file_name.begins_with("."):
				dir.remove(file_name)
			file_name = dir.get_next()
		print("Cleared slot ", slot_number)
		# Recreate the empty slot directory
		DirAccess.make_dir_recursive_absolute(slot_path)
		return true
	return false

# Delete all save data
func delete_all_saves() -> bool:
	var success = true
	for slot in range(1, 4):
		if not delete_slot(slot):
			success = false
	print("Deleted all save data")
	return success

# Check if a file exists in current slot
func file_exists(filename: String) -> bool:
	var slot_path = base_path + "slot" + str(current_slot) + "/"
	return FileAccess.file_exists(slot_path + filename)

# List all files in current slot
func list_slot_files() -> Array:
	var files = []
	var slot_path = base_path + "slot" + str(current_slot) + "/"
	var dir = DirAccess.open(slot_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not file_name.begins_with("."):
				files.append(file_name)
			file_name = dir.get_next()
	return files
