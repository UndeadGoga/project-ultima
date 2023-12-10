extends CharacterBody2D

var target_position: Vector2
var speed: float = 50.0

func _ready():
	# Установить начальную целевую позицию
	set_random_target()

func _process(delta):
	# Движение врага к целевой позиции
	move_toward_target(delta)
	# Проверка, достиг ли враг целевой позиции
	if position.distance_to(target_position) < 1.0:
		set_random_target()

func set_random_target():
	# Выбор случайной точки в радиусе 10 пикселей
	var random_offset = Vector2(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	target_position = position + random_offset

func move_toward_target(delta):
	# Плавное движение к целевой позиции
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
