extends CellItem
class_name TestItem


func OnPlay():
	modulate = Color.BLUE
	#var dup = self.duplicate() as TestItem
	#dup.OwnerCell = null
	#dup.State = CellItem.States.NotInCell
	#dup.find_child("ToolTip").hide()
	#dup.global_position.y -= 200
	#get_parent().add_child(dup)
