extends Area2D

var is_player_close = false

@export var npc_dialogue: DialogueResource = preload("res://Dialogos/default.dialogue")
@export var portrait: Texture2D
var destino: Vector2
var existe_destino = false
@export var velocidad := 20
	
	
func _process(delta: float):
	
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
	actualizar_animacion()
	
	
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


func _physics_process(delta: float) -> void:
	direccion = Vector2.ZERO 
	if is_player_close:
		return
	
	$RayCast2D.target_position = direccion * 13
	


func actualizar_animacion():
	if direccion == Vector2.ZERO:
		$AnimatedSprite2D.play("Abajo")
		$AnimatedSprite2D.stop()
		return
			
