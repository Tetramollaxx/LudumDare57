extends Node2D
class_name Board

@export var Cells : Array[Cell]

func _ready() -> void:
	main.board = self
	main.OnPlayItem.connect(check_winner)
	Cells.resize(9)
	for c in Cells.size():
		Cells[c] = %Cells.get_child(c)
		print(str(c) + " " + str(Cells[c]))
		
# Проверка на победу
func check_winner(Item : CellItem) -> void:
	# Горизонтали
	for row in range(3):
		var start_index = row * 3  # Начало строки
		if Cells[start_index].Item != null:
			if Cells[start_index].Item.Team != null and Cells[start_index].Item.Team == Cells[start_index + 1].Item.Team and Cells[start_index + 1].Item.Team == Cells[start_index + 2].Item.Team:
				if not Cells[start_index].Item.Team == G.Teams.NoTeam or not Cells[start_index].Item.Team == G.Teams.Null:
					main.game.end_game(Cells[start_index].Item.Team)
					return

	# Вертикали
	for col in range(3):
		if Cells[col].Item != null:
			if Cells[col].Item.Team != null and Cells[col].Item.Team == Cells[col + 3].Item.Team and Cells[col + 3].Item.Team == Cells[col + 6].Item.Team:
				if not Cells[col].Item.Team == G.Teams.NoTeam or not Cells[col].Item.Team == G.Teams.Null:
					main.game.end_game(Cells[col].Item.Team)
					return

	# Диагонали
	if Cells[0].Item != null:
		if Cells[0].Item.Team != null and Cells[0].Item.Team == Cells[4].Item.Team and Cells[4].Item.Team == Cells[8].Item.Team:
			if not Cells[0].Item.Team == G.Teams.NoTeam or not Cells[0].Item.Team == G.Teams.Null:
				main.game.end_game(Cells[0].Item.Team)
				return
	if Cells[2].Item != null:
		if Cells[2].Item.Team != null and Cells[2].Item.Team == Cells[4].Item.Team and Cells[4].Item.Team == Cells[6].Item.Team:
			if not Cells[2].Item.Team == G.Teams.NoTeam or not Cells[2].Item.Team == G.Teams.Null:
				main.game.end_game(Cells[2].Item.Team)
				return

	print("Нет победителя — игра продолжается")


func get_ai_move() -> int:
	var ai_team = G.Teams.Enemy
	var player_team = G.Teams.Player
	var null_team = [G.Teams.Null, G.Teams.NoTeam]
	
	var win_lines = [
		[0,1,2], [3,4,5], [6,7,8],  # горизонтали
		[0,3,6], [1,4,7], [2,5,8],  # вертикали
		[0,4,8], [2,4,6]            # диагонали
	]

	# 1. Попробовать победить
	for line in win_lines:
		var values = [(Cells[line[0]] as Cell).Item.Team, Cells[line[1]].Item.Team, Cells[line[2]].Item.Team]
		if values.count(ai_team) == 2 and values.count(null_team) == 1:
			return line[values.find(null_team)]

	# 2. Заблокировать игрока
	for line in win_lines:
		var values = [Cells[line[0]].Item.Team, Cells[line[1]].Item.Team, Cells[line[2]].Item.Team]
		if values.count(player_team) == 2 and values.count(null_team) == 1:
			return line[values.find(null_team)]

	# 3. Взять центр, если свободен
	for i in null_team:
		if Cells[4].Item.Team == i:
			return 4

	# 4. Взять угол
	for i in [0, 2, 6, 8]:
		for j in null_team:
			if Cells[i].Item.Team == j:
				return i

	# 5. Взять любую свободную
	for i in range(9):
		if Cells[i].Item.Team == G.Teams.Null or Cells[i].Item.Team == G.Teams.NoTeam:
			return i

	return -1  # Нет доступных ходов


func clearBoard():
	for c in Cells:
		c.Item.queue_free()
		c.Item = CellItem.new()
