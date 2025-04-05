extends Area2D

@export var isFlipped : bool
@export var ToolT : ToolTip
func _on_mouse_entered() -> void:
	if isFlipped:
		ToolT.tool_tip_w.flip_h = true
	ToolT.show()


func _on_mouse_exited() -> void:
	ToolT.hide()
