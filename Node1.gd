# DialogueManager.gd - This script is attached to a node that manages dialogue display
extends Node

var dialogue_texts = {
	1: "Welcome to the sandbox game!",
	2: "This is another piece of dialogue.",
	# Add more dialogue IDs and texts as needed
}

func _ready():
	GlobalSignals.alert_message.connect(_on_alert_message)  # Updated for Godot 4.2

func _on_alert_message(id):
	if id in dialogue_texts:
		show_dialogue(dialogue_texts[id])

func show_dialogue(text):
	# Assuming you have a RichTextLabel or similar node for displaying the dialogue
	$DialogueUI/DialogueLabel.text = text
	# Add any additional logic for showing or animating the dialogue UI
