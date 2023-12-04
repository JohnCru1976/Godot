extends CharacterBody2D

signal move_scenario(direction, speed, delta)

var speed = 0
const MAX_SPEED = 1500
const JUMP_VELOCITY = -700.0
var jumping = false

const ACCELERATION = 5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _init():
	pass

func _ready():
	position.x = screen_width / 3
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if jumping == true:
			rotation = ((- PI / 10) * velocity.y) / JUMP_VELOCITY
	else:
		if velocity.y == 0:
			jumping = false
		rotation = 0
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and jumping == false:
		velocity.y = JUMP_VELOCITY
		jumping = true
	
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		#if position.x < (screen_width * 0.45) and direction == -1:
		#	move_scenario.emit(direction,SPEED,delta)
		#	velocity.x = move_toward(velocity.x, 0, SPEED)
		#if direction == 1:
			if (speed >= 0 and direction > 0) or (speed <= 0 and direction < 0):
				speed += direction * ACCELERATION
				print(ACCELERATION)
			else:
				# Brake - Opposed direction
				speed += direction * ACCELERATION * 1.5
				print(ACCELERATION * 1.5)
			#velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if abs(speed) > 0:
			# Inertial braking
			speed += (-1 * speed / abs(speed)) * ACCELERATION / 10
		else:
			speed = 0
	if abs(speed) > MAX_SPEED:
		speed = (speed / abs(speed)) * MAX_SPEED
	print(speed)
	move_scenario.emit(speed,delta)
	
	move_and_slide()
