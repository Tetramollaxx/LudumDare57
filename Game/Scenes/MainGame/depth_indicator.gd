extends Node2D


@export var game : Game 
@export var Start: Node2D
@export var End: Node2D
@export var Indicator : Node2D

func SetIndicator(newValue: int) -> void:
	var t = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(Indicator, "global_position:y", (((End.global_position - Start.global_position) / game.DeadlyDepth) * game.Depth).y, 2)
	$DiverPlayer/RichTextLabel2.text = "[wave]" + str((main.game.DeadlyDepth - main.game.Depth) * 10)
