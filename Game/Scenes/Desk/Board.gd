extends Node2D
class_name Board


@export var Cells : Array[Cell]


func _ready() -> void:
	main.board = self
