extends Node2D
class_name Hand

@export var center : Node2D  # Центр круга (можно заменить на позицию руки игрока)
@export var radius = 200  # Радиус веера
@export var spread_degrees = 60  # Общий угол веера, например 60°
@onready var cards = get_children()  # Или любой массив твоих карт
var base_angle = -87  # Центр веера направлен ВНИЗ

func _ready() -> void:
	main.hand = self

func _physics_process(delta: float) -> void:
	var count = cards.size()
	spread_degrees = cards.size() * 5
	for i in range(count):
		if G.ActiveDraggedItem == cards[i]:
			continue
		var angle_offset = -spread_degrees / 2 + (spread_degrees / max(count - 1, 1)) * i
		var angle_deg = base_angle + angle_offset
		var angle_rad = deg_to_rad(angle_deg)
		
		var pos = center.global_position + Vector2(cos(angle_rad), sin(angle_rad)) * radius
		cards[i].global_position = lerp(cards[i].global_position, pos, delta * G.DraggingSpeed)
		cards[i].rotation_degrees = angle_deg  # Поворот чтобы "смотреть" в сторону
