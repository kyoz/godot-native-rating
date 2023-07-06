extends Node


func _ready():
	Rating.init()
	
	var _o = Rating.connect("on_completed", self, "_on_completed")
	var _o2 = Rating.connect("on_error", self, "_on_error")


func _on_error(error_code):
	print("Rating failed with error: " + error_code)


func _on_completed():
	print("Rating Completed")


func _on_Button_pressed():
	Rating.show()
