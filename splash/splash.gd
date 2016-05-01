extends Node2D
var timer = null
func _ready():
	timer = get_node("Timer")
	timer.connect("timeout", self, "_timeout")
	timer.set_wait_time(2)
	timer.start()

func _timeout():
	get_node("/root/Controller").goto_scene("res://welcome/welcome.tscn")
	timer.stop()