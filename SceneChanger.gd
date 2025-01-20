extends Node


func change_scene(new_scene_path: String):
	var load_screen = preload("res://loading_screen.tscn").instantiate()
	get_tree().root.add_child(load_screen)
	load_screen.start_loading(new_scene_path)

