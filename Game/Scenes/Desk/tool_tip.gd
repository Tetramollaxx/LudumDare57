extends Node2D
class_name ToolTip 


@export_multiline var TipText : String = "test"


func _ready() -> void:
	%TipText.text = TipText
