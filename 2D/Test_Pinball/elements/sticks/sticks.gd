extends Node2D



# Called when the node enters the scene tree for the first time.
func _draw():
	$StickRight.activate_right_stick()
	set_stick_gap(1000)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left_stick"):
		$StickLeft.activate_stick(delta)
	else:
		$StickLeft.deactivate_stick(delta)
	if Input.is_action_pressed("right_stick"):
		$StickRight.activate_stick(delta)
	else:
		$StickRight.deactivate_stick(delta)

func set_stick_gap(gap):
	$StickRight.position.x += gap

