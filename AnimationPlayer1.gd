extends AnimationPlayer

var animations = {
	"1": "forward",
	"wait": 1.0,  # 2 second wait
	"2": "tilt",
	"3": "special_move",
	"4": "dodge",
	"5": "block"
}

var animation_sequences = [
	{ "start": 1, "end": 5 },
	{ "start": 2, "end": 4 }
]

var animation_active = false
var current_animation_id = 0
var is_standalone_animation = false
var active_sequence_index = -1

func _ready():
	print("AnimationPlayer ready")
	Animationhandlercutscene.alert_message.connect(_on_alert_message)
	print("Connected to signals")

func _on_alert_message(id):
	print("Received signal: ", id)
	await get_tree().create_timer(3).timeout
	
	var numeric_id = int(id)
	var found_sequence = false
	
	for sequence in animation_sequences:
		if numeric_id >= sequence.start and numeric_id <= sequence.end:
			start_animation_sequence(sequence.start, sequence.end)
			found_sequence = true
			break
	
	if not found_sequence and str(numeric_id) in animations:
		play_standalone_animation(numeric_id)

func start_animation_sequence(start_id: int, end_id: int):
	active_sequence_index = find_sequence_index(start_id)
	print("Starting animation sequence from ID:", start_id, " to ID:", end_id)
	animation_active = true
	current_animation_id = start_id
	is_standalone_animation = false
	play_next_in_sequence(current_animation_id)

func play_standalone_animation(id: int):
	print("Playing standalone animation ID:", id)
	animation_active = true
	is_standalone_animation = true
	current_animation_id = id
	play_next_in_sequence(id)

func play_next_in_sequence(id):
	var current = str(id)
	
	# Play current animation
	if current in animations:
		if animations[current] is float:  # It's a wait
			print("Waiting for ", animations[current], " seconds")
			await get_tree().create_timer(animations[current]).timeout
			if !is_standalone_animation:
				advance_animation()
		elif has_animation(animations[current]):
			print("Playing: ", animations[current])
			play(animations[current])
			await animation_finished
			
			# Check for wait after animation
			var has_wait = "wait" in animations
			if has_wait and !is_standalone_animation:
				print("Waiting for ", animations["wait"], " seconds")
				await get_tree().create_timer(animations["wait"]).timeout
			
			if !is_standalone_animation:
				advance_animation()

func advance_animation():
	if animation_active and active_sequence_index != -1:
		var sequence = animation_sequences[active_sequence_index]
		if current_animation_id < sequence.end:
			current_animation_id += 1
			play_next_in_sequence(current_animation_id)
		else:
			active_sequence_index = -1
			animation_active = false

func find_sequence_index(start_id: int) -> int:
	for i in range(len(animation_sequences)):
		var sequence = animation_sequences[i]
		if sequence.start == start_id:
			return i
	return -1
