extends Panel

func _ready():
	
	var data = SaveManager.read_data("items.txt")
	
	# Check if the data contains "gun" and get the ID
	if "gun" in data:
		var id = data.split(" ")[1]  # Gets the number after "gun "
		print("Gun ID: ", id)
		print()

	
