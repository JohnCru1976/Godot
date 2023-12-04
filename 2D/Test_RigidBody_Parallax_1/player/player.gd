extends RigidBody2D

signal move_scenario(speed, delta)

const ACCELERATION = 20
const MAX_SPEED = 1000
const JUMP_VELOCITY = -700.0
var speed = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _init():
	pass

func _ready():
	pass
	
func _physics_process(delta):
#	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		apply_impulse(Vector2(0,JUMP_VELOCITY))
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if (speed >= 0 and direction > 0) or (speed <= 0 and direction < 0):
			
			speed += direction * ACCELERATION 
			
		else:
			# Brake - Opposed direction
			speed += direction * ACCELERATION * 2
	else:
		if abs(speed) > 0:
			# Inertial braking
			speed += (-1 * speed / abs(speed)) * ACCELERATION / 10
		else:
			speed = 0
			
	if abs(speed) > MAX_SPEED:
		speed = (speed / abs(speed)) * MAX_SPEED
	move_scenario.emit(speed,delta)
