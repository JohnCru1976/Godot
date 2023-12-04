extends RigidBody2D

signal body_touched(body)
signal shape_touched(body, shape_index)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	body_touched.emit(body)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	shape_touched.emit(body,body_shape_index)
