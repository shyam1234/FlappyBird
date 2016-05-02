extends Control;
var bird = null
var birdBody = null
var ground = null
var score = 0
var playing = false
var overSceneClass = preload("res://gameover/gameover.tscn")
var overScene = null
var _initBirdPos
func _init():
	seed(float(OS.get_unix_time()))

func _ready():
	bird = get_node("Collisons/Bird")
	birdBody = bird.get_node("Body")
	_initBirdPos = birdBody.get_pos()
	set_process_input(true)
	set_process(true)
	get_node("Score").hide()
	
	
func _input(event):
	if event.is_action_pressed("tap"):
		if not playing:
			_start()
	
func _process(delta):
	get_node("Speed/fps").set_text(str(int(1/delta)))
	if birdBody.is_colliding() and not bird.dead:
		var c = birdBody.get_collider()
		if c == get_node("Collisons/Ground/StaticBody2D"):
			bird.die(true)
			bird.Active = false
			_gameOver()
		var pipes = get_node("Collisons/Pipes/Container").get_children()
		for p in pipes:
			if c == p.get_node("Up") or c == p.get_node("Down"):
				bird.die(false)
				_gameOver()
	if not playing and not get_node("Tutorial").is_visible():
		get_node("Tutorial").show()
		birdBody.set_pos(_initBirdPos)

func onBodyPassPipe(body):
	if body == birdBody:
		score += 1
		get_node("Score").Value = score
		bird.passPipe()

func _start():
	get_node("Score").show()
	get_node("Tutorial").hide()
	playing = true

	bird.reset()
	birdBody.move_to(bird.get_pos())
	get_node("Collisons/Pipes").Active = true
	

func _gameOver():
	get_node("Collisons/Ground/anim").stop_all()
	get_node("Collisons/Pipes").Active = false
	get_node("Score").hide()
	overScene= overSceneClass.instance()
	overScene.score = score
	add_child(overScene)

func reset():
	remove_child(overScene)
	score = 0
	bird.Active = false
	get_node("Score").Value = 0
	get_node("Collisons/Pipes").reset()
	get_node("Collisons/Ground/anim").play("translate")
	playing = false
	
	