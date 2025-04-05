extends Node2D
class_name Game

@export var Depth : int = 3:
	set(new_value):
		Depth = new_value
		OnDepthChanged.emit(new_value)
		if Depth >= DeadlyDepth:
			Death()
@export var DeadlyDepth : int = 6

signal OnDepthChanged(newValue : int)

func _ready() -> void:
	main.game = self
	main.OnPlayItem.connect(Turn)
	OnDepthChanged.connect($DepthIndicator.SetIndicator)

func Death():
	print("YOu dead! Mu hahah ahaha h")

func Turn(Item : CellItem):
	print("Turn")
	if G.CurrentTurn == G.Turns.Player:
		G.CurrentTurn = G.Turns.Enemy
		await get_tree().create_timer(randf_range(1,4)).timeout
		var Aipos = main.board.get_ai_move()
		if Aipos == -1:
			G.CurrentTurn = G.Turns.Player
			return
		print(Aipos)
		var test = preload("res://Game/Scenes/CellItems/DefaultCardO/default_card_o.tscn")
		var t2 = test.instantiate()
		t2.Team = G.Teams.Enemy
		t2.State = CellItem.States.NotInCell
		t2.rotation = deg_to_rad(-90)
		t2.global_position = main.board.Cells[Aipos].global_position
		add_child(t2)
		await get_tree().create_timer(randf_range(1,1.3)).timeout
		G.CurrentTurn = G.Turns.Player
	

func end_game(winner_team : G.Teams) -> void:
	if winner_team == G.Teams.Null or winner_team == G.Teams.NoTeam:
		return
	if winner_team == G.Teams.Enemy:
		Depth += 1
		print("enemy win")
		%AnimationPlayer.play("Lose")
		await get_tree().create_timer(4).timeout
		main.board.clearBoard()
		return
	print("player win")
	await get_tree().create_timer(4).timeout
	main.board.clearBoard()
	Depth -= 1
