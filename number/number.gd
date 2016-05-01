extends Control;
export(int, 0, 99999999) var Value = 0;
var numberTexs = []

var _showingValue = -1

func _init():
	for i in range(10):
		numberTexs.append(load(str("res://number/font_", i, ".png")))

func _ready():
	set_process(true)
	
func _process(delta):
	if not _showingValue == Value:
		for s in get_children():
			remove_child(s)
			s.free()
			
		var numberStr = str(Value)
		for i in range(numberStr.length()):
			var s = Sprite.new()
			add_child(s)
			s.add_to_group("__number_sprite")
			var tex = numberTexs[int(numberStr[i])]
			s.set_texture(tex)
			s.set_pos(Vector2(tex.get_size().width * i, 0))
		_showingValue = Value