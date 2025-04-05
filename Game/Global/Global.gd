extends Node
class_name Global

@export var DraggingSlot : bool
@export var ActiveDraggedItem : CellItem

@export var CurrentTurn : Turns = Turns.Player

# GAME SETTINGS
@export var IsDebug : bool = true

# CONSTANTS
@export var DraggingSpeed : float = 15
enum Teams {
	Player,
	Enemy,
	NoTeam,
	Null
}
enum Turns {
	Player,
	Enemy
}
