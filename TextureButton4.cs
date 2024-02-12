using Godot;
using System;

public partial class TextureButton4 : TextureButton
{
	public override void _Ready()
	{
		Connect("pressed", new Callable(this, nameof(OnButtonPressed)));
	}

	private void OnButtonPressed()
	{
		GD.Print("Menu pressed");
	}
}
