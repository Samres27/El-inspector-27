extends CanvasLayer


func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_salir_creditos() -> void:
	$Creditos.visible=false
	
func _on_creditos_pressed() -> void:
	$Creditos.visible=true
	


func _on_configurar_pressed() -> void:
	$SettingsMenu.visible=true
