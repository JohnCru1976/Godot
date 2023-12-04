extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	print(mob_types)
	print(mob_types.size())
	var random = randi()
	print(random)
	$AnimatedSprite2D.play(mob_types[random % mob_types.size()])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Makes the mobs delete themselves when they leave the screen
	queue_free() 
