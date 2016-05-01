extends Node2D;
export var Speed = 100
var sprites = null
var width
func _ready():
	sprites = get_node("StaticBody2D").get_children()
	sprites.pop_back()
	width = get_node("StaticBody2D/Sprite").get_texture().get_size().width
	# set_process(true)
	print(str(sprites))
	
func _process(delta):
	for s in sprites:
		var pos = s.get_pos()
		pos.x -= Speed * delta
		if pos.x <= - width/2:
			pos.x = width/2;
		s.set_pos(pos)