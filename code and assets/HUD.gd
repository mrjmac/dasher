extends CanvasLayer

signal start_game
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_game_over():
	show_message("Game Over")
	yield(get_tree().create_timer(1), "timeout")
	
	$Message.text = "Dasher"
	$Message.show()
	$StartButton.show()
	
func hide_title():
	$Message.hide()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	pass
	#$Message.hide()




func _on_StartButton_pressed():
	$StartButton.hide()
	hide_title()
	emit_signal("start_game")
