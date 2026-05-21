extends Node2D

var player = preload("res://Scenes/player.tscn")
var new_player = null
var valid_player = false
func _process(delta):

	if !is_instance_valid(new_player) and valid_player:
		reset_game()

func _on_iniciar_pressed() -> void:
	new_player=player.instantiate()
	var new_position = Vector2(355, 420)
	new_player.position= new_position
	$Control.visible=false
	valid_player = true
	self.add_child(new_player)

func reset_game():
	get_tree().reload_current_scene()
