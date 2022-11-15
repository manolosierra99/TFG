extends Spatial

var tam_viewport;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Cubo_final.get_surface_material(0).set_shader_param("ViewportTextureTraseras",$Viewport_traseras.get_texture())
	$Cubo_final.get_surface_material(0).set_shader_param("ViewportTextureDelanteras",$Viewport_delanteras.get_texture())
	tam_viewport = get_node("/root").get_size_override();

"""
func _process(delta):
	var nuevo_tam = get_node("/root").get_size_override();
	if (nuevo_tam != tam_viewport):
		print(nuevo_tam);
		tam_viewport = nuevo_tam;
		$Viewport_delanteras.set_size_override(true,nuevo_tam);
		$Viewport_traseras.set_size_override(true,nuevo_tam);
	
"""
