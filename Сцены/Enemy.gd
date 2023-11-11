extends CharacterBody2D


var speed = 300
var detection_radius = 500
var attack_radius = 50  # Радиус, на котором враг атакует игрока
var wander_time = 2.0  # Время блуждания в одном направлении
var attack_delay = 1.0  # Задержка между атаками

@onready var player = $"../Player"
var wandering = false
var enemy_velocity = Vector2()
var time_since_last_attack = 0.0

func _physics_process(delta):
	if player.global_position.distance_to(global_position) < detection_radius:
		if player.global_position.distance_to(global_position) < attack_radius:
			# Если игрок в радиусе атаки
			time_since_last_attack += delta
			if time_since_last_attack > attack_delay:
				attack_player()
				time_since_last_attack = 0.0
		else:
			# Установить скорость движения в направлении игрока
			velocity = (player.global_position - global_position).normalized() * speed
			move_and_slide()
			wandering = false
	elif not wandering:
		start_wandering()

func start_wandering():
	wandering = true
	velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * speed
	var timer = Timer.new()
	timer.wait_time = wander_time
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_wander_timer_timeout"))
	add_child(timer)
	timer.start()

func _on_wander_timer_timeout():
	wandering = false

func attack_player():
	# Логика атаки игрока. Например, уменьшение здоровья игрока.
	pass
