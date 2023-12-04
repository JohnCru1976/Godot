extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	get_input()
	move_and_slide()

func get_input():
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	
 
