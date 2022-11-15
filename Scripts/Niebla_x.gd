extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vector
var opacidad_minima
var opacidad_maxima

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vector = Vector3($Niebla_x.get_value(),$Niebla_y.get_value(),$Niebla_z.get_value())
	get_node("/root/Spatial/Viewport_traseras/Cubo_traseras").set_scale(vector)
	get_node("/root/Spatial/Viewport_delanteras/Cubo_delanteras").set_scale(vector)
	get_node("/root/Spatial/Cubo_final").set_scale(vector)

	opacidad_minima = $Opacidad_minima.get_value()
	opacidad_maxima = $Opacidad_maxima.get_value()
	if (opacidad_minima < opacidad_maxima):
		get_node("/root/Spatial/Cubo_final").get_surface_material(0).set_shader_param("minimo_opacidad",opacidad_minima)
		get_node("/root/Spatial/Cubo_final").get_surface_material(0).set_shader_param("maximo_opacidad",opacidad_maxima)
