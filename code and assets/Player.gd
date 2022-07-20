extends Area2D

var pos = Vector2.ZERO
var screen_size
var move = true

signal hit

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(start):
	position = start
	show()
	$CollisionShape2D.disabled = false

func _process(_delta):
	if move == true :
		if Input.is_action_just_pressed("move_right") && pos.x < 2 :
			move = false
			pos.x += 1
			$movementTimer.start()
		elif Input.is_action_just_pressed("move_left") && pos.x > 0 :
			move = false
			pos.x -= 1
			$movementTimer.start()
		elif Input.is_action_just_pressed("move_up") && pos.y > 0 :
			move = false
			pos.y -= 1
			$movementTimer.start()
		elif Input.is_action_just_pressed("move_down") && pos.y < 2 :
			move = false
			pos.y += 1
			$movementTimer.start()
	
	if pos.x == 1:
		position.x = 360
	elif pos.x == 0:
		position.x = 250
	elif pos.x == 2:
		position.x = 470
	if pos.y == 1:
		position.y = 240
	elif pos.y == 0:
		position.y = 130
	elif pos.y == 2:
		position.y = 350
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)



func _on_movementTimer_timeout():
	move = true


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
