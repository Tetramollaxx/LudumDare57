extends Area2D

@export var isFlipped : bool

func _on_mouse_entered() -> void:
	if isFlipped:
		$ToolTip.tool_tip_w.flip_h = true
	$ToolTip.show()


func _on_mouse_exited() -> void:
	$ToolTip.hide()
