extends Node
# Assuming camera_node is properly defined and accessible
@onready var camera = get_node("main/SpringArmPivot/SpringArm3D/Camera3D4")
@onready var camera1 = get_node("Node3D/Camera3D3")

func _process(delta):
	if camera or camera1.current:
		process()
		ready()

func ready():
	if not GlobalSignals.alert_message.is_connected(_on_alert_message):
		GlobalSignals.alert_message.connect(_on_alert_message)

var dialogue_texts = {
	1: "Why did you click the O button?",
	2: "This is another piece of dialogue.",
	3: "(Char) welcome to the game.",
	4: "Click play to play.",
	5: "M for Menu",
	6: "Esc then y to exit",
	# Add more dialogue IDs and texts as needed
}

var dialogue_active = false
var current_dialogue_id = 0
var is_standalone_dialogue = false  # Flag to indicate if the current dialogue is standalone
var dialogue_sequences = [
	{ "start": 1, "end": 3 },
	{ "start": 9, "end": 10 }
	# Add more sequences as needed
]
var active_sequence_index = -1  # Index of the currently active sequence in dialogue_sequences

func process():
	if dialogue_active and Input.is_action_just_pressed("next_dialogue"):
		advance_dialogue()
	elif dialogue_active and Input.is_action_just_pressed("ui_cancel"):
		hide_dialogue()

func _on_alert_message(id):
	var found_sequence = false
	for sequence in dialogue_sequences:
		if id >= sequence.start and id <= sequence.end:
			start_dialogue_sequence(sequence.start, sequence.end)
			found_sequence = true
			break
	if not found_sequence and id in dialogue_texts:
		show_standalone_dialogue(id)

func start_dialogue_sequence(start_id: int, end_id: int):
	active_sequence_index = find_sequence_index(start_id)
	print("Starting dialogue sequence from ID:", start_id, "to ID:", end_id)
	dialogue_active = true
	current_dialogue_id = start_id
	is_standalone_dialogue = false  # Ensure this is marked as part of a sequence
	show_dialogue(current_dialogue_id)

func show_standalone_dialogue(id: int):
	print("Showing standalone dialogue ID:", id)
	dialogue_active = true
	is_standalone_dialogue = true
	current_dialogue_id = id
	show_dialogue(current_dialogue_id)

func show_dialogue(id: int):
	if id in dialogue_texts:
		$Sprite2D/RichTextLabel.text = dialogue_texts[id]
		$Sprite2D/RichTextLabel.visible = true
	else:
		print("Dialogue ID not found.")
		hide_dialogue()

func hide_dialogue():
	$Sprite2D/RichTextLabel.text = ""
	dialogue_active = false
	$Sprite2D/RichTextLabel.visible = false
	active_sequence_index = -1
	is_standalone_dialogue = false
	print("Dialogue system deactivated.")

func advance_dialogue():
	print("Attempting to advance dialogue...")
	if dialogue_active:
		print("Dialogue is active")
		if active_sequence_index != -1:
			print("Active sequence index:", active_sequence_index)
			var sequence = dialogue_sequences[active_sequence_index]
			print("Current dialogue ID before increment:", current_dialogue_id)
			if current_dialogue_id < sequence.end:
				current_dialogue_id += 1
				print("Advancing to dialogue ID:", current_dialogue_id)
				show_dialogue(current_dialogue_id)
			else:
				print("Reached the end of the dialogue sequence.")
				hide_dialogue()
		else:
			print("No active sequence.")
	else:
		print("Dialogue system is not active.")


func find_sequence_index(start_id: int) -> int:
	for i in range(len(dialogue_sequences)):
		var sequence = dialogue_sequences[i]
		if sequence.start == start_id:
			return i
	return -1
