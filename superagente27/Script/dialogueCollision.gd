extends Area2D

var is_player_close = false
const PERSONAJE_1 = preload("res://Dialogos/personaje1.dialogue")

func _process(delta: float):
	if is_player_close and Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_dialogue_balloon(PERSONAJE_1,"start")
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D):
	print("colision data")
	if body.name == "Player":
		is_player_close = true

func _on_body_exited(body: Node2D):
	if body.name == "Player":
		set_collision_layer_value(3, false)
