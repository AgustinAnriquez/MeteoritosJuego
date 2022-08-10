extends NaveBase
class_name EnemigoBase

func _ready():
	canion.set_esta_disparando(true)

## Señales Internas
func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()
