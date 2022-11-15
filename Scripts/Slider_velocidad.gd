extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("/root/Spatial/Cubo_final").get_surface_material(0).set_shader_param("velocidad",get_value())
