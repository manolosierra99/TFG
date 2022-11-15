extends Spatial


var player_rotation
var origen
var nueva_posicion
var altura_player
var diferencia_altura


# Called when the node enters the scene tree for the first time.
func _ready():
	player_rotation = get_node("/root/Spatial/Player/RotationHelper")
	origen = get_translation().y
	altura_player = get_node("/root/Spatial/Player").get_translation().y
	diferencia_altura = origen-altura_player


func _process(delta):
	nueva_posicion = player_rotation.get_global_transform()
	self.set_global_transform(nueva_posicion)
	self.global_translate(Vector3(0,diferencia_altura,0))
