extends KinematicBody

var dir = Vector3()
var camera
var rotation_helper
var vel = Vector3()

var MOUSE_SENSITIVITY = 0.05

const MAX_SPEED = 20
const ACCEL = 4.5
const DEACCEL = 16
const MAX_SLOPE_ANGLE = 40

func _ready():
	camera = get_node("RotationHelper/Camera")
	rotation_helper = get_node("RotationHelper")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	

func process_input(delta):
	
	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	var input_movement_vector = Vector2()
	
	# Con esto capturamos el movimiento que pretende realizar el personaje en 
	# unos ejes relativos a su posición
	
	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	
	input_movement_vector = input_movement_vector.normalized()
	
	# Ahora tenemos que tener en cuenta la rotación del personaje
	# para elegir el movimiento
	
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	
	# Capturar o liberar el cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	vel.y = 0
	
	var hvel = vel
	
	var target = dir
	target *= MAX_SPEED
	
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL
	
	hvel = hvel.linear_interpolate(target,accel*delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel,Vector3(0,1,0),0.05,4,deg2rad(MAX_SLOPE_ANGLE))
	
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY*-1))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY*-1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70,70)
		rotation_helper.rotation_degrees = camera_rot
		
