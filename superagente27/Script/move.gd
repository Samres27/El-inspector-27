#extends CharacterBody2D
#
#var move: bool = false
#static var current_z: int = 0  # Contador global compartido entre todas las instancias
#@export var imagen_textura:CompressedTexture2D
#
#func _ready():
	#$imagen.texture = imagen_textura
#
#func _process(_delta: float) -> void:
	#if move:
		#global_position = get_global_mouse_position()
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_released("click"):
		#move = false
#
#func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#if event.is_action_pressed("click"):
		#move = true
#
		## Incrementa el z_index global y se lo asigna a este nodo
		#current_z += 1
		#z_index = current_z
#
		#get_viewport().set_input_as_handled()
#


#extends CharacterBody2D
#
#var move: bool = false
#static var current_z: int = 0
#
#@export var imagen_textura: CompressedTexture2D
#
#func _ready():
	#$imagen.texture = imagen_textura
	#_generar_collision()
#
#
#func _generar_collision():
	#var image = imagen_textura.get_image()
#
	#var bitmap = BitMap.new()
	#bitmap.create_from_image_alpha(image)
#
	#var rect = Rect2(Vector2.ZERO, image.get_size())
	#var polygons = bitmap.opaque_to_polygons(rect)
#
	## Offset para centrar
	#var offset = image.get_size() / 2.0
#
	## Limpiar anteriores
	#for child in $Area2D.get_children():
		#if child is CollisionPolygon2D:
			#child.queue_free()
#
	#for poly in polygons:
		#var collision = CollisionPolygon2D.new()
#
		## Centrar el polígono
		#var centered_poly = PackedVector2Array()
#
		#for point in poly:
			#centered_poly.append((point - offset)*0.5)
#
		#collision.polygon = centered_poly
#
		#$Area2D.add_child(collision)
#
#func _process(_delta: float) -> void:
	#if move:
		#global_position = get_global_mouse_position()
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_released("click"):
		#move = false
		#
#
#func _on_area_2d_input_event(_viewport, event, _shape_idx):
	#if event.is_action_pressed("click"):
		#move = true
#
		#current_z += 1
		#z_index = current_z
#
		#get_viewport().set_input_as_handled()

extends CharacterBody2D

var move: bool = false
static var current_z: int = 0

@export var imagen_textura: CompressedTexture2D

func _ready():
	$imagen.texture = imagen_textura
	_generar_collision()


func _generar_collision():
	var image = imagen_textura.get_image()

	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)

	var rect = Rect2(Vector2.ZERO, image.get_size())
	var polygons = bitmap.opaque_to_polygons(rect)

	# Offset para centrar
	var offset = image.get_size() / 2.0

	# Limpiar anteriores
	for child in $Area2D.get_children():
		if child is CollisionPolygon2D:
			child.queue_free()

	for poly in polygons:
		var collision = CollisionPolygon2D.new()

		# Centrar el polígono
		var centered_poly = PackedVector2Array()

		for point in poly:
			centered_poly.append((point - offset)*0.5)

		collision.polygon = centered_poly

		$Area2D.add_child(collision)

func _process(_delta: float) -> void:
	if move:
		global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		move = false
		

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("click"):
		move = true

		current_z += 1
		z_index = current_z

		get_viewport().set_input_as_handled()
