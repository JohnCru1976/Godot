extends CharacterBody3D

@onready var spring_arm_pivot = $SpringArmPivot
@onready var spring_arm = $SpringArmPivot/SpringArm3D
@onready var armature = $Armature
@onready var anim_tree = $AnimationTree

const SPEED = 5.0
const LERP_VAL = .15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		spring_arm_pivot.rotate_y(-event.relative.x * .005)
		spring_arm.rotate_x(-event.relative.y * .005)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI/4, PI/4)
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction  = direction.rotated(Vector3.UP, spring_arm_pivot.rotation.y)
	
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, LERP_VAL)
		velocity.z = lerp(velocity.z, direction.z * SPEED, LERP_VAL)
		armature.rotation.y = lerp_angle(armature.rotation.y, atan2(-velocity.x, -velocity.z), LERP_VAL)
	else:
		velocity.x = lerp(velocity.x, 0.0, LERP_VAL)
		velocity.z = lerp(velocity.z, 0.0, LERP_VAL)
		
	anim_tree.set("parameters/BlendSpace1D/blend_position", velocity.length() / SPEED)

	move_and_slide()
	
	# Itera sobre todas las colisiones que ocurrieron durante el último movimiento
	for col_idx in get_slide_collision_count():
		# Obtiene la colisión en el índice actual
		var col := get_slide_collision(col_idx)
	# Comprueba si el colisionador es un RigidBody3D
		if col.get_collider() is RigidBody3D:
			# Si es así, aplica un impulso central al RigidBody3D
			# El impulso se aplica en la dirección opuesta a la normal de la colisión (es decir, "empuja" al RigidBody3D)
			# El valor 0.3 es la magnitud del impulso, puedes ajustarlo a tus necesidades
			col.get_collider().apply_central_impulse(-col.get_normal() * 0.3)
			# También aplica un impulso en el punto de colisión
			# Esto puede causar que el RigidBody3D gire, dependiendo de dónde ocurra la colisión
			# El valor 0.01 es la magnitud del impulso, puedes ajustarlo a tus necesidades
			col.get_collider().apply_impulse(-col.get_normal() * 0.01, col.get_position())

