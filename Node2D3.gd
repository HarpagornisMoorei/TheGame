extends Node2D

# Declare the new signal
signal health_damaged(damage_amount)

func _ready():
	# Optionally, connect the signal to ensure that the receiver is ready
	# You can also manually connect it in the other script if you prefer
	print("Node2D3 ready. Signal health_damaged is emitted on button press.")
	
func _process(delta):
	# Check for user input (press "C" to simulate damage)
	if Input.is_action_just_pressed("damage_health"):
		print("Play pressed")
		# Emit the signal with a damage amount of 10
		emit_signal("health_damaged", 5)
