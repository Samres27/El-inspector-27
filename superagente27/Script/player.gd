
extends CharacterBody2D

var direccion: Vector2

@export var speed := 50.0
@export var speed_run := 100.0

var mapa_instancia = null
var mapa_escena = preload("res://Scenes/mapa.tscn")
@onready var map_container = $CanvasLayer/MapController

var is_player_close = false
var is_active_dialoge = false
var read_map=false
var block_map=true

func _physics_process(delta):
	if not GlobalDialogue.is_dialogue_active and not read_map:
		direccion = Input.get_vector(
			"izquierda",
			"derecha",
			"arriba",
			"abajo"
		)
		var current_speed = speed_run if Input.is_action_pressed("correr") else speed
		
		if Input.is_action_pressed("correr"):
			$AnimatedSprite2D.speed_scale = 2.0
		else:
			$AnimatedSprite2D.speed_scale = 1.0
		velocity = direccion * current_speed
		move_and_slide()
		actualizar_animacion()

func _input(event):

	if event.is_action_pressed("map"):
		if not block_map:
			if mapa_instancia == null :
				abrir_mapa()
			else:
				cerrar_mapa()
			
func _on_mapa_pressed():
	if mapa_instancia == null:
		abrir_mapa()
	else:
		cerrar_mapa()
			
func abrir_mapa():
	mapa_instancia = mapa_escena.instantiate()
	map_container.add_child(mapa_instancia)
	read_map=true


func cerrar_mapa():
	mapa_instancia.queue_free()
	mapa_instancia = null
	read_map=false

func actualizar_animacion():
	if direccion == Vector2.ZERO:
		$AnimatedSprite2D.stop()
		return
	if abs(direccion.x) > abs(direccion.y):
		if direccion.x < 0:
			$AnimatedSprite2D.play("Izquierda")
		else:
			$AnimatedSprite2D.play("Derecha")
	else:
		if direccion.y < 0:
			$AnimatedSprite2D.play("Arriba")
		else:
			$AnimatedSprite2D.play("Abajo")
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player_close = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_close = false

func dialogo_activo (dialogo) :
	is_active_dialoge = true
	
func dialogo_desactivo(dialogo):
	await get_tree().create_timer(0.2).timeout
	is_active_dialoge = false


func _on_configuracion_pressed() -> void:
	$CanvasLayer/SettingsMenu.visible=true


func _on_salir_pressed() -> void:
	self.queue_free()
