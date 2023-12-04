extends AnimatableBody2D

const PULL_SPEED = 700
const PULL_LIMIT = 130
var release_speed = PULL_SPEED * 5
var initial_position

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("launch"):
		pull_stick(delta)
	else:
		release_stick(delta)
	
func release_stick(delta):
	if position.y < initial_position:
		position.y = initial_position
	elif position.y > initial_position:
		position.y -= (release_speed + random_int(50)) * delta
		
func pull_stick(delta):
	if position.y > initial_position + PULL_LIMIT:
		position.y = initial_position + PULL_LIMIT
	elif position.y - initial_position < PULL_LIMIT:
		position.y += PULL_SPEED * delta
	
func random_int(num):
	randomize()
	return randi() % (num +1)
