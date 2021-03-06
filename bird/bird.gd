extends Node2D

export(int,0, 600) var DownSpeed = 200.0;
export(int,0, 1000) var JumpSpeed = 400.0;
export(float) var JumpDuration = 0.35;
export var Active = false
export var dead   = false

var jumpSpeed = JumpSpeed
var body = null
var timer = null
var sprite = null
var direction = Vector2(0, 1)
var animName

func _ready():
	body   = get_node("Body")
	timer  = get_node("Timer")
	set_process(true)
	set_process_input(true)
	
	randomize()
	animName = str("frame", int(rand_range(0,3)))
	get_node("anim").play(animName)
	
	get_node("Sounds/Player").play("swooshing")
	get_node("Sounds/Timer").connect("timeout",self, "_playDropSound")
	timer.connect("timeout", self, "_goDown")

func _input(event):
	if Active and event.is_action_pressed("tap"):
		jump()

func reset():
	Active = true
	dead = false
	get_node("anim").play(animName)

func die(onGround):
	dead = true
	get_node("Sounds/Player").play("bird_hit")
	get_node("anim").stop_all()
	if not onGround:
		if get_node("Sounds/Timer").is_processing():
			get_node("Sounds/Timer").stop()
		get_node("Sounds/Timer").set_wait_time(0.35)
		get_node("Sounds/Timer").start()

func jump():
	if Active and not dead:
		direction.y = -1
		var duration = JumpDuration # + timer.get_time_left()
		timer.set_wait_time(duration)
		if duration != JumpDuration:
			timer.stop()
			jumpSpeed *= 1.5
		else:
			jumpSpeed = JumpSpeed
		timer.start()
		get_node("Sounds/Player").play("bird_swing")

func passPipe():
	get_node("Sounds/PintPlayer").play("bird_point")

func _process(delta):
	if Active:
		var speed = DownSpeed
		body.set_rot(deg2rad(-17))
		if direction.y == -1:
			speed = jumpSpeed
			body.set_rot( deg2rad(17))
		var step = direction * (speed * delta)
		body.move(step)
	if dead:
		body.set_rot( deg2rad(-90))
	
func _goDown():
	direction.y = 1
	timer.stop()

func _playDropSound():
	get_node("Sounds/Player").play("bird_drop")
	get_node("Sounds/Timer").stop()
