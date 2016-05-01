extends Node2D

func _ready():
	get_node("StartButton").connect("pressed", self, "_onStart")

func _onStart():
	get_node("/root/Controller").goto_scene("res://main/main.tscn")