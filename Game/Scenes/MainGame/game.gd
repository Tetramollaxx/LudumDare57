extends Node2D
class_name Game

@export var Depth : int = 5:
	set(new_value):
		Depth = new_value
		if Depth >= DeadlyDepth:
			Death()
@export var DeadlyDepth : int = 10

func _ready() -> void:
	main.game = self

func Death():
	print("YOu dead! Mu hahah ahaha h")
