extends Node2D;
var MaxSpace = 10;
var MinSpace = 5;
var landHeight = preload("res://ground/land.png").get_size().height

func _ready():
	var pipeHeight = get_node("Up/Sprite").get_texture().get_size().height * get_node("Up/Sprite").get_scale().y
	var height = get_viewport_rect().size.height - landHeight
	
	randomize()
	
	var access = get_node("Access")
	var accesscale = Vector2(1, rand_range(MinSpace,MaxSpace))
	access.set_scale(accesscale)
	var accessize = get_node("Access/Control").get_size() * 2 * accesscale 
	var accessPos = Vector2(0, rand_range(accessize.height/2, height-accessize.height/2));
	access.set_pos(accessPos)
	access.connect("body_enter", self, "_bodyExitPipe")
	
	var accessOffset = Vector2(0, accessPos.y - 300)
	
	var upPos = get_node("Up").get_pos() + accessOffset
	upPos.y -= accessize.height/2
	get_node("Up").set_pos(upPos)
	
	var downPos = get_node("Down").get_pos() + accessOffset
	downPos.y +=  accessize.height/2
	get_node("Down").set_pos(downPos)
	
	
func _bodyExitPipe(body):
	print(get_node("/root/Control").onBodyPassPipe(body))