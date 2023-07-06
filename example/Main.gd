extends Node


func _ready():
	Rating.init()
	
	var _o = Rating.connect("on_finished", self, "_on_finished")


func _on_finished(msg):
	print(msg)


func _on_Button_pressed():
	Rating.request()
