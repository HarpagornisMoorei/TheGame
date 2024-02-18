extends TextureButton

@onready var texture_rect = get_node("../TextureRect")
@onready var close_button = get_node("../close")

func _ready():
	# Hide the TextureRect and close button initially
	texture_rect.visible = false
	close_button.visible = true

	# Connect the 'pressed' signal for this TextureButton to its function
	pressed.connect(_on_TextureButton2_pressed)

func _on_TextureButton2_pressed():
	# Toggle the visibility of texture_rect when TextureButton2 is pressed
	texture_rect.visible = not texture_rect.visible
