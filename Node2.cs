using Godot;
using System;

public partial class Node2 : Node // Notice the 'partial' keyword here
{
	public override void _Ready()
	{
		GD.Print("Hello, World!");
	}
}
