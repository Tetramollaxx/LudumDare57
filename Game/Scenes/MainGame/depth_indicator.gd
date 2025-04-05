extends Node2D


@export var game : Game 
@export var Start: Node2D
@export var End: Node2D
@export var Indicator : Node2D

func _physics_process(_delta: float) -> void:
	Indicator.global_position.y = (((End.global_position - Start.global_position) / game.DeadlyDepth) * game.Depth).y
