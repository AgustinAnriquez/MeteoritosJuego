#MenuPrincipal.gd
extends Node

func _ready() -> void:
	MusicaJuego.play_musica(MusicaJuego.get_lista_musicas().menu_principal)



func _on_BotonJugar_pressed() -> void:
	MusicaJuego.play_boton()
	get_tree().change_scene("res://Juego/Niveles/nivelTest.tscn")
