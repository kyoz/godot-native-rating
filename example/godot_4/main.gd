extends Node


func _ready():
	pass
	Rating.init()
	Rating.on_completed.connect(_on_completed)
	Rating.on_error.connect(_on_error)


func _on_error(error_code):
	print("Rating failed with error: " + error_code)


func _on_completed():
	print("Rating Completed")


func _on_button_pressed():
	Rating.show()
