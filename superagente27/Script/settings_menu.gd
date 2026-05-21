extends Control

@onready var slider = $Panel/MarginContainer/VBoxContainer/HSlider


func _ready():

	slider.value_changed.connect(_on_volume_changed)
	resolution_option.add_item("1280x720")
	resolution_option.add_item("1920x1080")
	resolution_option.add_item("2560x1440")

	resolution_option.item_selected.connect(_on_resolution_selected)


func _on_volume_changed(value):

	var db = linear_to_db(value / 100.0)

	AudioServer.set_bus_volume_db(0, db)
	
@onready var resolution_option = $Panel/MarginContainer/VBoxContainer/OptionButton

func _on_resolution_selected(index):

	match index:

		0:
			DisplayServer.window_set_size(Vector2i(1280, 720))

		1:
			DisplayServer.window_set_size(Vector2i(1920, 1080))

		2:
			DisplayServer.window_set_size(Vector2i(2560, 1440))


func _on_button_pressed() -> void:
	self.visible=false
