extends Node3D

''' Node3Ds have a local transform, which is relative to the parent node 
(as long as the parent node is also of or inherits from the type Node3D). 
This transform can be accessed as a 4×3 Transform3D, 
or as 3 Vector3 members representing location, Euler rotation 
(X, Y and Z angles) and scale.'''

func _ready():
	print(type_string(typeof(transform))) # Transform3D
	print(transform)
	print(transform.basis)
	print(transform.origin)
	print(transform.basis.x)
	print(transform.basis["y"][1])
	print(transform.origin)
	
	print(type_string(typeof(position))) # Vector3
	print(position)
	print(rotation)
	print(scale)
