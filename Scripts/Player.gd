extends CharacterBody2D

@export var speed: int = 100
@onready var anim: Sprite2D = $Sprite2D
var health = 100

func handleInput():
	var moveDirection = Vector2.ZERO
	moveDirection.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	moveDirection.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	moveDirection = moveDirection.normalized()
	velocity = moveDirection * speed
	
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/castle_1.tscn")

	# Переключение горизонтального отображения спрайта
	if moveDirection.x != 0:
		anim.flip_h = moveDirection.x < 0

func _physics_process(delta):
	handleInput()
	move_and_slide()


