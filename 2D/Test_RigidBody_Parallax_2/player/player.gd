extends RigidBody2D

signal move_scenario(speed, delta)

const ACCELERATION = 400000
const MAX_SPEED = 1000
const JUMP_VELOCITY = -30000.0
var speed = 200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _init():
	pass

func _ready():
	pass
	
func _physics_process(delta):
#	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		apply_impulse(Vector2(0,JUMP_VELOCITY * delta))

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		apply_central_force(Vector2(ACCELERATION * direction * delta, 0.0))

		
	# move_scenario.emit(speed,delta)

