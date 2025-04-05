extends Node2D
class_name CellItem

enum States {
	NotInCell,
	InCell
}
@export var State : States = States.NotInCell
@export var OwnerCell : Cell
@export var IsDragging : bool = false
@export var IsHovered : bool = false

func _physics_process(delta: float) -> void:
	CheckIsDragging()
	CheckCellCollisions()
	if State == States.InCell:
		global_position = OwnerCell.global_position
	if IsDragging:
		global_position = lerp(global_position, get_global_mouse_position(), delta * G.DraggingSpeed)

func CheckIsDragging():
	if State == States.NotInCell:
		if Input.is_action_pressed("Action1"):
			if IsHovered or IsDragging:
				IsDragging = true
				return
	IsDragging = false

func _on_collision_detecter_mouse_entered() -> void:
	if not IsDragging: $ToolTip.show()
	IsHovered = true
func _on_collision_detecter_mouse_exited() -> void:
	$ToolTip.hide()
	IsHovered = false

func CheckCellCollisions():
	if not %CollisionDetecter.get_overlapping_areas():
		return
	if not is_node_ready():
		return
	for area in %CollisionDetecter.get_overlapping_areas():
		if IsDragging:
			if not IsDragging: print(IsDragging)
			if State == States.NotInCell:
				PlaceInCell(area)

func PlaceInCell(cell):
	cell.Item = self
	OwnerCell = cell
	State = States.InCell
	modulate = Color.RED
	OnPlay()

func OnPlay():
	pass
