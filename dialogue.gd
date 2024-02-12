# Assuming this script is attached to a RichTextLabel node
extends RichTextLabel

func _ready():
	# Connect the 'alert_message' signal from the GlobalSignals autoloaded node to this node's '_on_alert_message' method
	GlobalSignals.connect("alert_message", self, "_on_alert_message")

func _on_alert_message(id):
	if id == 1:
		self.text = "Hi"  # Use 'self.bbcode_text' if BBCode is enabled in the RichTextLabel
