extends CharacterBody2D

class_name TopDownController

@export var speed = 500.0
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

var direction : Vector2

func _process(_delta):
	pass

func _physics_process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	
	var dir = Input.get_axis("move_up", "move_down")
	if dir:
		velocity.y = dir * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	update_animation()
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	update_animation()
	move_and_slide()
	



func update_animation():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
		
	if velocity.x:
		anim.play("Run")
	elif velocity.y < 0:
		anim.play("RunUp")
	elif velocity.y > 0:
		anim.play("RunDown")
	else:
		anim.play("idle")
