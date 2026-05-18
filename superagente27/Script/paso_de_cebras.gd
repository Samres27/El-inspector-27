# Script para el Area2D del paso de peatón
extends Area2D

func _ready():
	# Conecta las señales
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.name == "Player":
		set_collision_layer_value(3, true)

func _on_body_exited(body: Node2D):
	if body.name == "Player":
		set_collision_layer_value(3, false)
