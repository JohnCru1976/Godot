extends CharacterBody2D


var speed
var normal_speed = 9000.0
var accelerate_speed = 20000.0
var rotation_direction = 0
var rotation_speed = 1.5

func input():
	if Input.is_action_pressed("click"):
		look_at(get_global_mouse_position())
	if Input.is_action_pressed("space"):
		speed = accelerate_speed
	else:
		speed = normal_speed
	

func _physics_process(delta):
	input()
	var movement_vector = Input.get_vector("left","right","up","down")
	velocity = movement_vector * speed * delta
	move_and_slide()
