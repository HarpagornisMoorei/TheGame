extends Node

var dialogue_texts = {
	1: "Welcome to the sandbox game!",
	2: "This is another piece of dialogue.",
	3: "Another piece of the story.",
	4: "Yet another important message.",
	# Add more dialogue IDs and texts as needed
}

var dialogue_active = false
var current_dialogue_id = 0
var is_standalone_dialogue = false  # Flag to indicate if the current dialogue is standalone
var dialogue_sequences = [
	{ "start": 3, "end": 4 },
	{ "start": 5, "end": 8 }
	# Add more sequences as needed
]
var active_sequence_index = -1  # Index of the currently active sequence in dialogue_sequences

func _ready():
	GlobalSignals.alert_message.connect(_on_alert_message)

func _process(delta):
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
	if is_standalone_dialogue:
		print("Hiding standalone dialogue.")
		hide_dialogue()
	elif active_sequence_index != -1:
		var sequence = dialogue_sequences[active_sequence_index]
		if current_dialogue_id < sequence.end:
			current_dialogue_id += 1
			show_dialogue(current_dialogue_id)
		else:
			print("Reached the end of the dialogue sequence.")
			hide_dialogue()

func find_sequence_index(start_id: int) -> int:
	for i in range(len(dialogue_sequences)):
		var sequence = dialogue_sequences[i]
		if sequence.start == start_id:
			return i
	return -1
