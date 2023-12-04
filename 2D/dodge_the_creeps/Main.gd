extends Node

@export var mob_scene: PackedScene
var score
var record

# Called when the node enters the scene tree for the first time.
func _ready():
	record = get_record()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	if score > record:
		$HUD.update_record("Record: " + str(record))
		set_record(score)
		record = score	 
	$Music.stop()
	$HUD.show_game_over()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$DeathSound.play()
	

func new_game():
	score = 0
	$Music.play()
	# Eliminar todas las instancias existentes de mobs
	get_tree().call_group("mobs", "queue_free")
	if record > 0:
		$HUD.update_record("Record: " + str(record))
	else:
		$HUD.update_record("")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()  ## ??

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func get_record():
	if not FileAccess.file_exists("user://savegame.save"):
		return 0
	
	var save_score = FileAccess.open("user://savegame.save", FileAccess.READ)
	save_score.get_position()
	var record_saved = int(save_score.get_line())
	
	return record_saved
	
func set_record(score):
	var save_score = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_score:
		save_score.store_line(str(score))
