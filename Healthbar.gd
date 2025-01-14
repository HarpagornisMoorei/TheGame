extends TextureRect

# Variables for health
static var max_health = 100
static var current_health = max_health
# Set the initial width of the health bar
static var initial_width = 40.0
# Healing rate in health points per second
static var healing_rate = max_health / 60.0  # Heal fully in 60 seconds
# Timer for healing
static var healing_timer : Timer
# Variables to handle smooth movement of the health bar
static var target_size = initial_width
static var lerp_speed = 5.0
# System control
static var system_enabled = false

func _ready():
	# Set initial width
	size.x = initial_width
	print("Initial size.x set to:", initial_width)
	
	# Connect the signal from the parent Node
	var connected = get_parent().connect("health_damaged", Callable(self, "_on_health_damaged_signal"))
	if connected == OK:
		print("Signal connected successfully.")
	else:
		print("Failed to connect signal.")
	
	# Connect to the emitter's toggle signal
	if not CentralScript.toggle_signal.is_connected(_on_toggle_signal):
		CentralScript.toggle_signal.connect(_on_toggle_signal)
	
	# Initialize the healing timer
	healing_timer = Timer.new()
	healing_timer.wait_time = 1
	healing_timer.one_shot = false
	healing_timer.connect("timeout", Callable(self, "_on_heal"))
	add_child(healing_timer)
	update_health_bar()

func _on_toggle_signal(target: String, state: int):
	if target == "h":  # Only handle 'h' signals
		print("Health system received state: ", state)
		if state == 1:
			system_enabled = true
			healing_timer.start()
			print("Health system enabled")
		else:
			system_enabled = false
			healing_timer.stop()
			print("Health system disabled")

func _on_health_damaged_signal(damage_amount):
	if not system_enabled:
		return
		
	print("Received damage:", damage_amount)
	current_health -= damage_amount
	current_health = max(current_health, 0)
	print("Current health:", current_health)
	update_health_bar()

func update_health_bar():
	if max_health > 0:
		var damage_percentage = (100 - (current_health * 100 / max_health))
		target_size = initial_width - (initial_width * damage_percentage / 100)
		print("New width:", target_size)
		
		if current_health == max_health:
			visible = false
		else:
			visible = true

func _process(delta):
	if not system_enabled:
		return
		
	if abs(size.x - target_size) > 0.1:
		size.x = lerp(size.x, target_size, lerp_speed * delta)
	else:
		if target_size <= 0.01:
			size.x = 0
		else:
			size.x = target_size

func _on_heal():
	if not system_enabled:
		return
		
	if current_health < max_health:
		current_health += healing_rate
		current_health = min(current_health, max_health)
		print("Healed to:", current_health)
		update_health_bar()
