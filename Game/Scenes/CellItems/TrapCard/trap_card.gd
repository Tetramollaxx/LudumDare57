extends CellItem
class_name TrapCard

func OnPlay():
	OwnerCell.OnSetItem.connect(Trap)


func Trap(Item : CellItem):
	if OwnerCell.Item.State == Item.States.Null:
		return
	Item.destroy()
	OwnerCell.Item = CellItem.new()
	self.destroy()
