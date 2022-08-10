#EnemigoDummy.gd
extends Node2D

export var hitpoints:float = 30.0

## Metodos

func _process(_delta: float) -> void:
	$Canion.set_esta_disparando(true)

## Metodos custom
func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		queue_free()

## Señales internas
func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.destruir()

