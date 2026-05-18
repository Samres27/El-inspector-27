extends CharacterBody2D

@onready var path_follow = get_parent()  # Asumiendo que es hijo de PathFollow2D
var speed = 20

var tiempo_pausa = 0.5
var pausa = true

var direccion: Vector2
var posicion_anterior: Vector2



func _physics_process(delta: float) -> void:
	direccion = Vector2.ZERO #para iniciar animacion estatica
	if $RayCast2D.is_colliding():
		return
		
	tiempo_pausa -= delta
	if pausa:
		
		if tiempo_pausa <= 0.0:
			pausa = false
			tiempo_pausa = randf_range(1.0, 10.0) #el rango de tiempo caminando
	else:
		if tiempo_pausa <= 0.0:
			print("puasando...")
			pausa = true
			tiempo_pausa = randf_range(0.5, 1) #el rango de tiempo de la pausa
		path_follow.progress += speed * delta
	var pos = path_follow.global_position
	direccion = (pos - posicion_anterior).normalized()
	$RayCast2D.target_position = direccion * 13
	posicion_anterior = pos

func _process(delta: float) -> void:
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
