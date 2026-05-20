extends Area2D

var is_player_close = false

@export var npc_dialogue: DialogueResource = preload("res://Dialogos/default.dialogue")
@export var portrait: Texture2D
var destino: Vector2
var existe_destino = false
@export var velocidad := 20
	
	
func _process(delta: float):
	actualizar_animacion()
	if is_player_close and Input.is_action_just_pressed("ui_accept") and not GlobalDialogue.is_dialogue_active:
		var balloon= DialogueManager.show_dialogue_balloon(npc_dialogue, "start")
		
		# 2. Si el Balloon se creó con éxito, le pasamos la textura directamente a su variable
		if balloon:
			balloon.set_portrait(portrait)
			
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	$Sprite2D.visible= false
	generar_nuevo_destino() 
	
func _on_dialogue_started(dialogue):
	GlobalDialogue.is_dialogue_active=true
	
func _on_dialogue_ended(dialogue):
	await  get_tree().create_timer(0.4).timeout
	GlobalDialogue.is_dialogue_active=false
	
func _on_body_entered(body: Node2D):
	if body.name == "Player":
		$Sprite2D.visible=true
		is_player_close = true

func _on_body_exited(body: Node2D):
	if body.name == "Player":
		$Sprite2D.visible= false
		is_player_close = false


@onready var path_follow = get_parent()  # Asumiendo que es hijo de PathFollow2D
var speed = 20

var tiempo_pausa = 0.5
var pausa = true

var direccion: Vector2
var posicion_anterior: Vector2

func generar_nuevo_destino():
	# Genera una nueva posición aleatoria dentro de un rango
	var rango = 50 #lo cambiamos segun el rango de movimiento deseado
	destino = global_position + Vector2(randf_range(-rango, rango), randf_range(-rango, rango))
	existe_destino = true
	
func movimiento():
	if existe_destino:
		
		# ¡Si el rayo detecta una pared en camino, recalculamos destino!
		if $RayCast2D.is_colliding():
			generar_nuevo_destino()
			return
		direccion = (destino - global_position).normalized()
		
		# Movemos la posición manualmente usando delta (puedes pasar delta como parámetro)
		global_position += direccion * velocidad * get_physics_process_delta_time()
		
		# Ya no puedes usar get_slide_collision_count() aquí
		
		if global_position.distance_to(destino) < 5:
			direccion = Vector2.ZERO
			existe_destino = false
			await get_tree().create_timer(randf_range(0.5, 5)).timeout
			generar_nuevo_destino()

func _physics_process(delta: float) -> void:
	direccion = Vector2.ZERO 
	if is_player_close:
		return
	
	movimiento() 
	$RayCast2D.target_position = direccion * 13
	


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
