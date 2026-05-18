extends Area2D

var is_player_close = false
@export var npc_dialogue: DialogueResource #= preload("res://Dialogos/personaje1.dialogue")
@export var portrait: Texture2D

	
	
func _process(delta: float):
	actualizar_animacion()
	if is_player_close and Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_dialogue_balloon(npc_dialogue,"start")
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	GlobalDialogue.portrait = portrait
	$Sprite2D.visible= false
	
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



func _physics_process(delta: float) -> void:
	direccion = Vector2.ZERO #para iniciar animacion estatica
	if $RayCast2D.is_colliding():
		return
		
	if is_player_close:
		return
	tiempo_pausa -= delta
	if pausa:
		
		if tiempo_pausa <= 0.0:
			pausa = false
			tiempo_pausa = randf_range(1.0, 10.0) #el rango de tiempo caminando
	else:
		if tiempo_pausa <= 0.0:
			pausa = true
			tiempo_pausa = randf_range(0.5, 1) #el rango de tiempo de la pausa
		path_follow.progress += speed * delta
	var pos = path_follow.global_position
	direccion = (pos - posicion_anterior).normalized()
	$RayCast2D.target_position = direccion * 13
	posicion_anterior = pos


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
