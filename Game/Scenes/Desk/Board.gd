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
				if not Cells[start_index].Item.Team == G.Teams.NoTeam:
					print("Победитель: " + str(Cells[start_index].Item.Team))
					end_game(str(Cells[start_index].Item.Team))
					return

	# Вертикали
	for col in range(3):
		if Cells[col].Item != null:
			if Cells[col].Item.Team != null and Cells[col].Item.Team == Cells[col + 3].Item.Team and Cells[col + 3].Item.Team == Cells[col + 6].Item.Team:
				if not Cells[col].Item.Team == G.Teams.NoTeam:
					print("Победитель: " + str(Cells[col].Item.Team))
					end_game(str(Cells[col].Item.Team))
					return

	# Диагонали
	if Cells[0].Item != null:
		if Cells[0].Item.Team != null and Cells[0].Item.Team == Cells[4].Item.Team and Cells[4].Item.Team == Cells[8].Item.Team:
			if not Cells[0].Item.Team == G.Teams.NoTeam:
				print("Победитель: " + str(Cells[0].Item.Team))
				end_game(str(Cells[0].Item.Team))
				return
	if Cells[2].Item != null:
		if Cells[2].Item.Team != null and Cells[2].Item.Team == Cells[4].Item.Team and Cells[4].Item.Team == Cells[6].Item.Team:
			if not Cells[2].Item.Team == G.Teams.NoTeam:
				print("Победитель: " + str(Cells[2].Item.Team))
				end_game(str(Cells[2].Item.Team))
				return

	print("Нет победителя — игра продолжается")

# Функция для завершения игры
func end_game(winner_team : String) -> void:
	print("Игра завершена! Победитель: " + winner_team)
	main.game.Depth -= 1
	# Здесь можно добавить логику для остановки игры, перезапуска или отображения UI
