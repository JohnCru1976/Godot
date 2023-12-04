extends AnimatableBody2D

const impulse_force = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_impulse(ball: RigidBody2D):
	var impulse_vector = ball.position - position
	ball.apply_impulse(impulse_vector.normalized() * impulse_force)
	
	
