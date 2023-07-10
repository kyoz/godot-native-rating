extends Node

signal on_error(error_code)
signal on_completed()

var rating = null


# Change this to _ready() if you want automatically init
func init():
	if Engine.has_singleton("Rating"):
		rating = Engine.get_singleton("Rating")
		init_signals()


func init_signals():
	rating.error.connect(_on_error)
	rating.completed.connect(_on_completed)


func _on_error(error_code):
	emit_signal("on_error", error_code)


func _on_completed():
	emit_signal("on_completed")


func show():
	if not rating:
		not_found_plugin()
		return
	
	rating.show()
	

func not_found_plugin():
	print('[Rating] Not found plugin. Please ensure that you checked Rating plugin in the export template')
