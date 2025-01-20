extends Control

@onready var loading_line = $LoadingLine
var next_scene = ""
var progress = []
var load_status = 0
var highest_progress = 0  # Track the highest progress value

func start_loading(scene_path: String):
	next_scene = scene_path
	loading_line.scale.x = 0
	highest_progress = 0  # Reset highest progress on new load
	show()
	var error = ResourceLoader.load_threaded_request(next_scene)
	if error != OK:
		print("Error starting scene load: ", error)

func _process(_delta: float) -> void:
	if next_scene == "":
		return
		
	load_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	
	if progress.size() > 0:
		var current_progress = progress[0]
		# Only update if the new progress is higher
		if current_progress > highest_progress:
			highest_progress = current_progress
		loading_line.scale.x = highest_progress * 10  # Use highest_progress instead of current
		print("Loading: ", highest_progress * 100, "%")
	
	if load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(next_scene)
		if scene:
			get_tree().change_scene_to_packed(scene)
			queue_free()
