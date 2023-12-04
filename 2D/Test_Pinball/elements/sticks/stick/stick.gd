extends AnimatableBody2D

const SPEED = 17
var INITIAL_ROTATION = PI / 15
const RANGE_MOVEMENT = - PI / 9
var stick_direction = 1  # Left: 1   Right: -1

# Called when the node enters the scene tree for the first time.
func _draw():
	set_collisions()
func _ready():
	pass

func activate_stick(delta):
	if rotation >= RANGE_MOVEMENT and stick_direction == 1:
		rotate(-stick_direction * SPEED * delta)
	if (((rotation / abs(rotation)) == -1 and rotation <= (-1 * (RANGE_MOVEMENT + PI))) or (rotation / abs(rotation)) == 1) and stick_direction == -1:
		rotate(-stick_direction * SPEED * delta)
	
func deactivate_stick(delta):
	if rotation <= INITIAL_ROTATION and stick_direction == 1:
		rotate(stick_direction * SPEED * delta)
	if (((rotation / abs(rotation)) == 1 and rotation >= (PI - INITIAL_ROTATION)) or (rotation / abs(rotation)) == -1) and stick_direction == -1:
		rotate(stick_direction * SPEED * delta)
	
func set_collisions():
	if stick_direction == -1:
		$CollisionShapeRight.disabled = false
		$CollisionShapeLeft.disabled = true
		rotation = -PI
	else:
		$CollisionShapeRight.disabled = true
		$CollisionShapeLeft.disabled = false
	
func activate_right_stick():
	stick_direction = -1
	
