extends Node

signal on_finished()

var rating = null

func init():
	if Engine.has_singleton("Rating"):
		rating = Engine.get_singleton("Rating")
		init_signals()


func init_signals():
	rating.connect("finished", self, "_on_finished")


func _on_finished(msg):
	emit_signal("on_finished", msg)


func request():
	if not rating:
		not_found_plugin()
		return
	
	rating.request()
	

func not_found_plugin():
	print('[Rating] Not found plugin. Please ensure that you checked Rating plugin in the export template')
