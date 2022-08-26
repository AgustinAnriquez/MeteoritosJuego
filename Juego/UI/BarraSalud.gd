#BarraSalud.gd
class_name BarraSalud
extends ProgressBar

## Atibutos export
export var siempre_visible: bool = false

## Atributos Onready
onready var tween_visibilidad:Tween = $TweenVisibilidad

func set_hitpoints_actual(hitpoints: float) -> void:
	value = hitpoints

## Metodos
func _ready() -> void:
	modulate = Color(1, 1, 1, siempre_visible)

## Metodos custom
func set_valores(hitpoints: float) -> void:
	max_value = hitpoints
	value = hitpoints

func controlar_barra(hitpoints_nave: float, mostrar:bool) -> void:
	value = hitpoints_nave
	if not tween_visibilidad.is_active() and modulate.a != int(mostrar):
		tween_visibilidad.interpolate_property(
			self,
			"modulate",
			Color(1,1,1,not mostrar),
			Color(1,1,1,mostrar),
			1.0,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		tween_visibilidad.start()

## Señales Internas
func _on_TweenVisibilidad_tween_all_completed():
	if modulate.a == 1.0:
		controlar_barra(value, false)
