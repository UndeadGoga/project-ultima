extends CharacterBody2D

var initial_position: Vector2
var speed: float = 50.0
var chase = false
var wandering = false
var waypoints = [] # Список точек для перемещения
var current_waypoint_index = 0
var damage_timer = Timer.new() # Создаем новый таймер

func _ready():
	add_child(damage_timer)
	damage_timer.wait_time = 2
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	initial_position = position # Сохраняем изначальную позицию
	setup_waypoints() # Настроить точки для перемещения

func setup_waypoints():
	# Здесь задайте точки, между которыми будет перемещаться персонаж
	waypoints.append(Vector2(100, 100))
	waypoints.append(Vector2(200, 300))
	waypoints.append(Vector2(300, 100))
	waypoints.append(Vector2(100, 200))

func _physics_process(delta: float) -> void:
	var player = $"../Player"
	var direction = (player.position - self.position).normalized()
	if chase:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	elif wandering:
		move_to_waypoint(delta)
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func move_to_waypoint(delta):
	var target = waypoints[current_waypoint_index]
	if position.distance_to(target) < 10:
		current_waypoint_index = (current_waypoint_index + 1) % waypoints.size()
	else:
		var dir_to_waypoint = (target - position).normalized()
		velocity.x = dir_to_waypoint.x * speed
		velocity.y = dir_to_waypoint.y * speed

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
		wandering = false
		damage_timer.start()

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
		wandering = true
		damage_timer.stop()

func _on_damage_timer_timeout():
	var player = $"../Player"
	if player:
		player.health -= 20

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		death()

func death():
	queue_free()

func _on_death_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health -= 40
