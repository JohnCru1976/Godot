extends Node2D

@export var floor_scene: PackedScene
@export var back_scene: PackedScene

var back_instances
var floor_instances
var width_elements = 1400

# Called when the node enters the scene tree for the first time.
func _ready():
	start_scenario()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func start_scenario():
	
	floor_instances = [floor_scene.instantiate(), floor_scene.instantiate(), floor_scene.instantiate()] 
	back_instances = [back_scene.instantiate(), back_scene.instantiate(), back_scene.instantiate()]
	
	floor_instances[0].position = Vector2(-width_elements, 570)
	floor_instances[1].position = Vector2(0, 570)
	floor_instances[2].position = Vector2(width_elements, 570)
	
	back_instances[0].position.x = -width_elements
	back_instances[1].position.x = 0
	back_instances[2].position.x = width_elements
	
	for i in range(0, 3):
		add_child(back_instances[i])
		add_child(floor_instances[i])
		
	
func move(speed, delta):
	for back in back_instances:
		back.position.x += (speed/10 * delta) * -1
	for floor in floor_instances:
		floor.position.x += (speed * delta) * -1
	
	if floor_instances[0].position.x < (width_elements + width_elements / 2) * -1:
		# Instance 0 goes to the end of the array
		var floor_instance_0 = floor_instances.front()
		floor_instance_0.position.x = floor_instances[2].position.x + width_elements
		floor_instances.pop_front()
		floor_instances.push_back(floor_instance_0)
	if back_instances[0].position.x < (width_elements + width_elements / 2) * -1:
		# Instance 0 goes to the end of the array
		var back_instance_0 = back_instances.front()
		back_instance_0.position.x = back_instances[2].position.x + width_elements
		back_instances.pop_front()
		back_instances.push_back(back_instance_0)
	if floor_instances[0].position.x > (width_elements / 2) * -1:
		var floor_instance_2 = floor_instances.back()
		floor_instance_2.position.x = floor_instances[0].position.x - width_elements
		floor_instances.pop_back()
		floor_instances.push_front(floor_instance_2)
	if back_instances[0].position.x > (width_elements / 2) * -1:
		var back_instance_2 = back_instances.back()
		back_instance_2.position.x = back_instances[0].position.x - width_elements
		back_instances.pop_back()
		back_instances.push_front(back_instance_2)
	
func _on_player_move_scenario(speed, delta):
	move(speed, delta)
