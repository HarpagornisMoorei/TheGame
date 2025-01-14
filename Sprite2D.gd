extends Sprite2D

static var system_enabled = false  # Changed default to false for d0 state

func _ready():
	# Connect the alert message signal to the handler
	if not GlobalSignals.alert_message.is_connected(_on_alert_message):
		GlobalSignals.alert_message.connect(_on_alert_message)
	
	# Connect to the emitter's toggle signal
	if not CentralScript.toggle_signal.is_connected(_on_toggle_signal):
		CentralScript.toggle_signal.connect(_on_toggle_signal)
		print("Connected to emitter toggle signals")
		print("Dialog system initialized in disabled state (d0)")
	
	# Ensure dialogue is hidden on startup
	hide_dialogue()

var dialogue_texts = {
	1: "Why did you click the O button?",
	2: "This is another piece of dialogue.",
	3: "(Char) welcome to the game.",
	4: "Click play to play.",
	5: "M for Menu",
	6: "Esc then y to exit",
}

var dialogue_active = false
var current_dialogue_id = 0
var is_standalone_dialogue = false
var dialogue_sequences = [
	{ "start": 1, "end": 3 },
	{ "start": 9, "end": 10 }
]
var active_sequence_index = -1

func _on_toggle_signal(target: String, state: int):
	if target == "to":  # Only handle 't' signals
		if state == 0:
			system_enabled = false  # Disable the entire system
			hide_dialogue()
			print("Dialog system disabled")
		elif state == 1:
			system_enabled = true  # Enable the system
			if current_dialogue_id > 0:
				show_dialogue(current_dialogue_id)
			print("Dialog system enabled")

func _process(_delta):
	if not system_enabled:  # Block all processing when system is disabled
		return
		
	if dialogue_active and Input.is_action_just_pressed("next_dialogue"):
		advance_dialogue()
	elif dialogue_active and Input.is_action_just_pressed("ui_cancel"):
		hide_dialogue()

func _on_alert_message(id):
	if not system_enabled:  # Block all incoming messages when system is disabled
		return
		
	var numeric_id = int(id)
	var found_sequence = false
	
	for sequence in dialogue_sequences:
		if numeric_id >= sequence.start and numeric_id <= sequence.end:
			start_dialogue_sequence(sequence.start, sequence.end)
			found_sequence = true
			break
	
	if not found_sequence and numeric_id in dialogue_texts:
		show_standalone_dialogue(numeric_id)

func show_dialogue(id: int):
	if not system_enabled:  # Block showing dialogue when system is disabled
		return
		
	if id in dialogue_texts:
		$RichTextLabel.text = dialogue_texts[id]
		$RichTextLabel.visible = true
		dialogue_active = true
	else:
		print("Dialogue ID not found.")
		hide_dialogue()

func start_dialogue_sequence(start_id: int, end_id: int):
	if not system_enabled:  # Block starting sequences when system is disabled
		return
		
	active_sequence_index = find_sequence_index(start_id)
	print("Starting dialogue sequence from ID:", start_id, "to ID:", end_id)
	dialogue_active = true
	current_dialogue_id = start_id
	is_standalone_dialogue = false
	show_dialogue(current_dialogue_id)

func show_standalone_dialogue(id: int):
	if not system_enabled:  # Block standalone dialogues when system is disabled
		return
		
	print("Showing standalone dialogue ID:", id)
	dialogue_active = true
	is_standalone_dialogue = true
	current_dialogue_id = id
	show_dialogue(current_dialogue_id)

func hide_dialogue():
	$RichTextLabel.text = ""
	dialogue_active = false
	$RichTextLabel.visible = false
	active_sequence_index = -1
	is_standalone_dialogue = false
	print("Dialogue system deactivated.")

func advance_dialogue():
	if not system_enabled:  # Block dialogue advancement when system is disabled
		return
		
	print("Attempting to advance dialogue...")
	if dialogue_active:
		if active_sequence_index != -1:
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
