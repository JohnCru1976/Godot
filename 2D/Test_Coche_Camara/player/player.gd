extends RigidBody2D

var speed = 400
var acceleration = 4000
var deceleration = 2000

func _physics_process(delta):
	var input_dir = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0)

	if input_dir.x != 0:
		# Acelera cuando se presiona una tecla
		linear_velocity.x = clamp(linear_velocity.x + acceleration * input_dir.x * delta, -speed, speed)
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, deceleration * delta)

	# Mueve el personaje 
	move_and_collide(linear_velocity * delta)
	print(position)
	print(linear_velocity)
	
	# Ajusta las propiedades linear_damp y angular_damp para reducir el temblor
	linear_damp = 7
	angular_damp = 7
