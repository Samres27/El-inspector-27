
extends CharacterBody2D

var direccion: Vector2

@export var speed := 50.0
@export var speed_run := 100.0


var is_player_close = false
var is_active_dialoge = false


func _physics_process(delta):

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
