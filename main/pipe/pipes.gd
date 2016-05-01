extends Node2D

export(float) var AddDuration = 1.6;
export(int,0, 800) var MoveSpeed = 200;
export var Active = true

var pipe  = preload("res://main/pipe/pipe.tscn")
var container = null
var timer = null

func _ready():
	timer = get_node("Timer");
	container = get_node("Container");
	timer.set_wait_time(AddDuration)
	timer.connect("timeout", self, "_addPipe")
	timer.start()
	set_process(true)

func _process(delta):
	if Active:
		var pipes = container.get_children()
		for p in pipes:
			var pos = p.get_pos()
			pos.x -=  MoveSpeed * delta
			if pos.x < -p.get_node("Up/Sprite").get_texture().get_size().width/2:
				container.remove_child(p)
			else:
				p.set_pos(pos)

func reset():
	for p in get_node("Container").get_children():
		get_node("Container").remove_child(p)

func _addPipe():
	if Active:
		var p = pipe.instance()
		p.set_pos(Vector2(get_viewport().get_rect().size.width, 0))
		container.add_child(p)