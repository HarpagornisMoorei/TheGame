# Attached to RichTextLabel, which is a part of MoneyApp UI
extends RichTextLabel

var money_amount := 10  # Initialize the money amount with $10

func _ready():
	# Connect to the SignalManager's update_money signal using Callable
	SignalManager.update_money.connect(Callable(self, "_on_UpdateMoney"))
	# Display the initial amount
	update_money_display()

func _on_UpdateMoney(amount: int):
	money_amount += amount
	update_money_display()

func update_money_display():
	# Update the RichTextLabel's text to show the current money amount
	text = "$" + str(money_amount)

func _on_HideAllButtons():
	# Assuming the RichTextLabel is part of a larger UI that should be hidden/shown
	get_parent().visible = false

func show_money_app():
	# Show the MoneyApp UI. Call this method to make the MoneyApp UI visible again
	get_parent().visible = true
	update_money_display()
