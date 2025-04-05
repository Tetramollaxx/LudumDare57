extends Area2D
class_name Cell


@export var Item : CellItem = CellItem.new():
	set(newV):
		Item = newV
		SetItem.emit(newV)

signal SetItem(Item)
