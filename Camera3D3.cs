using Godot;
using System;

public partial class Camera3D3 : Camera3D // Use 'partial' if you're using generated signals
{
	public override void _Ready()
	{
		var textureButtonPath = "../../TextureButton2"; // Adjust the path as necessary
		var textureButton = GetNodeOrNull<TextureButton>(textureButtonPath);

		if (textureButton != null)
		{
			// Correct way to connect signals in C#
			textureButton.Connect("pressed", new Callable(this, nameof(OnTextureButton2Pressed)));
		}
		else
		{
			GD.PrintErr("TextureButton2 not found. Please check the node path.");
		}
	}
	
	private void OnTextureButton2Pressed()
	{
		MakeCurrent();
		GD.Print("Camera3D3 is now active.");
	}
}
