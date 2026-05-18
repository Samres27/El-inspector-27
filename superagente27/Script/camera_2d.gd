extends Camera2D

@export var speed := 500.0

func _process(delta):
	var dir = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		dir.x += 1

	if Input.is_action_pressed("ui_left"):
		dir.x -= 1

	if Input.is_action_pressed("ui_down"):
		dir.y += 1

	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	position += dir.normalized() * speed * delta
