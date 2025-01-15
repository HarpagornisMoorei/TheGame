extends Node


func save_quest_progress():
	var main = get_node("/root/Main")
	main.save_manager.write_data("quests.txt", "quest1:complete quest2:active quest3:failed")
func _ready():
	# Switch to slot 1
	Slotsignalmanager.emit_slot_signal(1)
	
	# Save some data
	SaveManager.write_data("test.txt", "some data looool")
	SaveManager.write_data("items.txt", "gun 6")

func _input(event):
	if event.is_action_pressed("left"):  # "a" key
		SaveManager.write_data("items.txt", "gun 1")
		print("Wrote: gun 1")
	
