extends Node2D

var ball_scene = load("res://elements/ball/ball.tscn")
var num_balls = 1
var launch_force = -4000
var ball_instance: RigidBody2D
const BALL_INIT_POSITION = Vector2(1030,1500)
# Called when the node enters the scene tree for the first time.
func _ready():
	$UpperBouncers/RightUpperBouncer.activate_right()
	$Sticks1.call_deferred("set_stick_gap", -10)
	new_ball()

func _input(event):
	if event.is_action_pressed("new_ball"):
		new_ball()
		
func new_ball():
	if ball_instance:
		ball_instance.queue_free()
	ball_instance = ball_scene.instantiate()
	ball_instance.position = BALL_INIT_POSITION
	ball_instance.shape_touched.connect(self._on_ball_touching_shape)
	add_child(ball_instance)		
	
func _on_ball_touching_shape(body, shape_index):
	print(body.name, " - ", shape_index)
	var body_parent_name = ["BounceCircles", "UpperBouncers"]
	if  (body.get_parent().name in body_parent_name) and shape_index == 0:
		body.apply_impulse(ball_instance)
		
		
