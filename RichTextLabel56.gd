extends RichTextLabel

func _ready():
	var font = FontFile.new()
	font.font_data = load("res://path/to/your/font.ttf")
	font.size = 40  # Set the initial font size here
	$Sprite2D/RichTextLabel.add_font_override("normal_font", font)
