extends AnimatableBody2D

var bounce_force_x = 800
var bounce_force_y = 2 * bounce_force_x * 0.8
var bouncer_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_impulse(ball: RigidBody2D):
	if bouncer_direction  == 1:
		ball.apply_impulse(Vector2(bounce_force_x,-bounce_force_y))
	else:
		ball.apply_impulse(Vector2(-bounce_force_x,-bounce_force_y))

func activate_right():
	bouncer_direction = -1
