extends CellItem
class_name TestTrap


func OnPlay():
	OwnerCell.SetItem.connect(trap)

func trap(Item: CellItem):
	if OwnerCell.Item.State == Item.States.Null:
		return
	Item.queue_free()
	OwnerCell.Item = CellItem.new()
	queue_free()
