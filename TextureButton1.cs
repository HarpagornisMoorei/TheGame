using Godot;
using System;

public partial class TextureButton1 : TextureButton
{
	public override void _Ready()
	{
		Connect("pressed", new Callable(this, nameof(OnPlayButtonPressed)));
	}

	private void OnPlayButtonPressed()
	{
		GD.Print("Play pressed");

		// Switch to camera mode
		SwitchToCameraMode();

		// Hide other buttons
		HideButtons("TextureButton2", "TextureButton3", "TextureButton");
	}

	private void SwitchToCameraMode()
	{
		// Deactivate the initial camera (Camera3D2)
		Camera3D initialCamera = GetNode<Camera3D>("../Node3D/Camera3D2");
		if (initialCamera != null)
		{
			initialCamera.Current = false;
		}
		else
		{
			GD.PrintErr("Initial Camera3D2 node not found. Make sure the path is correct.");
		}

		// Activate the target camera (Camera3D)
		Camera3D targetCamera = GetNode<Camera3D>("../Node3D/Camera3D");
		if (targetCamera != null)
		{
			targetCamera.Current = true;
			GD.Print("Target Camera3D is now active.");
		}
		else
		{
			GD.PrintErr("Target Camera3D node not found. Make sure the path is correct.");
		}
	}

	private void HideButtons(params string[] buttonNames)
	{
		// Assuming all buttons are direct children of the same parent
		var parent = GetParent();
		GD.Print("Hiding buttons...");
		foreach (string name in buttonNames)
		{
			var button = parent.GetNodeOrNull<TextureButton>(name);
			if (button != null)
			{
				GD.Print("Hiding button: " + name);
				button.Visible = false;
			}
			else
			{
				GD.Print("Button not found: " + name);
			}
		}
	}
}
