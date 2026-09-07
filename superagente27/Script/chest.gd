extends Area2D

@export var npc_dialogue: DialogueResource = preload("res://Dialogos/default.dialogue")
var is_player_close = false
var see_lineedit= false

func _process(delta: float):
	if is_player_close and Input.is_action_just_pressed("ui_accept") and not GlobalDialogue.is_dialogue_active and not GlobalDialogue.line_edit_active:
		var balloon= DialogueManager.show_dialogue_balloon(npc_dialogue, "Inicio")
		see_lineedit=true
			
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_dialogue_started(dialogue):
	GlobalDialogue.is_dialogue_active=true
	
func _on_dialogue_ended(dialogue):
	if see_lineedit:
		GlobalDialogue.line_edit_active = true
		$CanvasLayer.visible=true
	else:
		$CanvasLayer.visible=false
		GlobalDialogue.line_edit_active = false
	await  get_tree().create_timer(0.4).timeout
	GlobalDialogue.is_dialogue_active=false
	
func _on_body_entered(body: Node2D):
	if body.name == "Player":
		is_player_close = true

func _on_body_exited(body: Node2D):
	if body.name == "Player":
		is_player_close = false

func verificar(cont):
	#flag: part1+part2+part3+}
	see_lineedit=false
	if "cfbe6730c0e4983ca7125ae4901e848ec19409342820220daed362dade26de58" == cont.sha256_text():
		DialogueManager.show_dialogue_balloon(npc_dialogue, "Correcto")
	else:
		DialogueManager.show_dialogue_balloon(npc_dialogue, "Erroneo")

func _on_button_pressed() -> void:
	var contrasena=$CanvasLayer/HBoxContainer/LineEdit.text
	if  contrasena == "":
		DialogueManager.show_dialogue_balloon(npc_dialogue, "Sin_Contrasena")
	else:
		verificar(contrasena)
	
