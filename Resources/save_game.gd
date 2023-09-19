extends Node

var save_file_path = "user://save/"
var save_file_name = "progress.tres"

var progress_res :Resource

func _ready() -> void:
	print("singleton ready")
	verify_save_dir()
	load_progress()
	save_progress()

func verify_save_dir():
	DirAccess.make_dir_absolute(save_file_path)

func load_progress():
	if FileAccess.file_exists(save_file_path + save_file_name):
		progress_res = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	else:
		progress_res = Progress.new()
		progress_res.init()
		save_progress()
	
func save_progress():
	ResourceSaver.save(progress_res, save_file_path + save_file_name)
