extends Node2D
class_name ToolTip 


@export_multiline var TipText : String = "test"
@export var TipName : String = "Card name "
@onready var tool_tip_w: Sprite2D = $ToolTipContainer/ToolTipW

func _ready() -> void:
	%TipText.text = TipText
	%CardName.text = TipName
