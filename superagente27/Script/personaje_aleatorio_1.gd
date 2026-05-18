extends CharacterBody2D

@onready var path_follow = get_parent()  # Asumiendo que es hijo de PathFollow2D
var speed = 20
@export var velocidad := 20
var direccion := Vector2.ZERO 
var destino: Vector2
var existe_destino = false


var posicion_anterior: Vector2

func _ready() -> void:
	generar_nuevo_destino() #generamos un destino inicial

func _physics_process(delta: float) -> void:
	direccion = Vector2.ZERO #para iniciar animacion estatica
	if $RayCast2D.is_colliding():
		return
	movimiento() 
	$RayCast2D.target_position = direccion * 13

func generar_nuevo_destino():
	# Genera una nueva posición aleatoria dentro de un rango
	var rango = 50 #lo cambiamos segun el rango de movimiento deseado
	destino = global_position + Vector2(randf_range(-rango, rango), randf_range(-rango, rango))
	existe_destino = true

func _process(delta: float) -> void:
	actualizar_animacion()
	
func movimiento():
	if existe_destino: #verificar que se tiene un destino
		direccion = (destino - global_position).normalized() #Direccion a tomar entre la posicion actual y el destino
		velocity = direccion * velocidad
		move_and_slide()
		
		if get_slide_collision_count() > 0:
			generar_nuevo_destino()
		
		# Verifica si llegó al destino
		if global_position.distance_to(destino) < 5:
			velocity = Vector2.ZERO
			existe_destino = false
			await get_tree().create_timer(randf_range(0.5, 5)).timeout  # esperamos 1.5 segundos
			generar_nuevo_destino()
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
