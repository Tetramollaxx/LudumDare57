extends Node2D
class_name CellItem

enum States {
	NotInCell,
	InCell,
	Null
}
@export var Team : G.Teams = G.Teams.Null
@export var State : States = States.Null
@export var OwnerCell : Cell
@export var IsDragging : bool = false
@export var IsHovered : bool = false

func _physics_process(delta: float) -> void:
	if State == States.Null: return
	CheckIsDragging()
	CheckCellCollisions()
	if State == States.InCell:
		global_position = OwnerCell.global_position
	if IsDragging and G.CurrentTurn != G.Turns.Enemy:
		global_position = lerp(global_position, get_global_mouse_position(), delta * G.DraggingSpeed)
		rotation = lerp_angle(rotation, deg_to_rad(-90), delta * G.DraggingSpeed)

func CheckIsDragging():
	if G.DraggingSlot:
		if G.ActiveDraggedItem != self:
			return
	
	if State == States.NotInCell and Team != G.Teams.Enemy :
		if Input.is_action_pressed("Action1") and (G.ActiveDraggedItem == null or G.ActiveDraggedItem == self):  
			if (IsHovered or IsDragging) :
				IsDragging = true
		if not Input.is_action_pressed("Action1"):
			IsDragging = false
	if IsDragging:
		G.DraggingSlot = true
		G.ActiveDraggedItem = self  
		return
	else:
		G.DraggingSlot = false
		G.ActiveDraggedItem = null 
	IsDragging = false


func _on_collision_detecter_mouse_entered() -> void:
	if not IsDragging: 
		%ToolTip.show()
		if %ToolTip.global_position.y<= 250:
			$RemoteTransform2D.global_position.y += 500
			$RemoteTransform2D.global_position.x -= 100
			%ToolTip.tool_tip_w.flip_v = true
	IsHovered = true
func _on_collision_detecter_mouse_exited() -> void:
	%ToolTip.hide()
	IsHovered = false

func CheckCellCollisions():
	if not %CollisionDetecter.get_overlapping_areas():
		return
	if not is_node_ready():
		return
	for area in %CollisionDetecter.get_overlapping_areas():
		if not IsDragging and area.Item.Team == G.Teams.Null or area.Item.Team == G.Teams.NoTeam:
			if State == States.NotInCell:
				PlaceInCell(area)

func PlaceInCell(cell):
	cell.Item = self
	OwnerCell = cell
	State = States.InCell
	OnPlay()
	if main.hand.cards.find(self) >= 0:
		main.hand.cards.remove_at(main.hand.cards.find(self))
	main.OnPlayItem.emit(self)

func destroy():
	queue_free()

func OnPlay():
	pass
