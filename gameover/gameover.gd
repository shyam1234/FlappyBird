extends Node2D
export(int) var score = 0;
var bestScore = 0
var isBest = false
func _ready():
	get_node("Panel/Score").Value = score
	get_node("RestartButton").connect("pressed", self, "_onRestart")
	set_process_input(true)
	
	var savepath = "user://savegame.save"
	var file = File.new()
	if file.file_exists(savepath):
		file.open(savepath, File.READ)
		if file.is_open():
			var text = file.get_as_text()
			var saveData = {}
			saveData.parse_json(text)
			bestScore = saveData["bestScore"]
	else:
		bestScore = bestScore
	
	if score >= bestScore:
		get_node("Panel/New").show()
		bestScore = score
		var saveData = {}
		saveData["bestScore"] = score
		file.open(savepath, File.WRITE)
		file.store_string(saveData.to_json())
		file.close()
	get_node("Panel/BestScore").Value = bestScore
	
	var tex = null
	if score >= 20:
		tex = load("res://gameover/medals_3.png")
	elif score >= 15:
		tex = load("res://gameover/medals_2.png")
	elif score >= 10:
		tex = load("res://gameover/medals_1.png")
	elif score >= 5:
		tex = load("res://gameover/medals_0.png")
	if tex:
		get_node("Panel/Medal").show()
		get_node("Panel/Medal/Sprite").set_texture(tex)
	else:
		get_node("Panel/Medal").hide()
		
func _input(event):
	if event.is_action("tap"):
		_onRestart()

func _onRestart():
	get_node("/root/Control").reset()