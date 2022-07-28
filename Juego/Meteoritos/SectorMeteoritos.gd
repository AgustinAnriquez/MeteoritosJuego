#SectorMeteoritos.gd
class_name SectorMeteoritos
extends Node2D

## Atributos
var spawners:Array
var cantidad_meteoritos:int = 10
var intervalo_spawn:float = 1.2

## Constructor
func crear(pos: Vector2, meteoritos: int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos

## Metodos
func _ready() -> void:
	almacenar_spawners()
	$SpawnTimer.wait_time = intervalo_spawn

## Metodos custom
func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()
	

	


func _on_SpawnTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
	
	spawners[spawner_aleatorio()].spawner_meteorito()
	cantidad_meteoritos -= 1
