extends Node

export(PackedScene) var mob_scene
var score
var ran = 1
#var topTypes = $warningTop.frames.get_animation_names()
#var bottomTypes = $warningBottom.frames.get_animation_names()
#var rightTypes = $warningRight.frames.get_animation_names()
#var leftTypes = $warningLeft.frames.get_animation_names()



# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.hide()
	$warningBottom.hide()
	$warningTop.hide()
	$warningLeft.hide()
	$warningRight.hide()
	$warningBottom.set_frame(0)
	$warningTop.set_frame(0)
	$warningLeft.set_frame(0)
	$warningRight.set_frame(0)
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$mobTimer.stop()
	$TextureRect.hide()
	$warningBottom.hide()
	$warningTop.hide()
	$warningLeft.hide()
	$warningRight.hide()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	ran = 1

func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($playerStart.position) 
	$TextureRect.show()
	$warningBottom.show()
	$warningTop.show()
	$warningLeft.show()
	$warningRight.show()
	$startTimer.start()
	get_tree().call_group("mobs", "queue_free")


func _on_mobTimer_timeout():
	$warningBottom.stop()
	$warningLeft.stop()
	$warningRight.stop()
	$warningTop.stop()
	var mob = mob_scene.instance()
	match ran:
		0:
			mob.position.x = 250
			mob.position.y = 240
			mob.rotation = 0
		1:
			mob.position.x = 360
			mob.position.y = 240
			mob.rotation = 0
		2:
			mob.position.x = 470
			mob.position.y = 240
			mob.rotation = 0
		3:
			mob.position.x = 360
			mob.position.y = 130
			mob.rotation = PI/2
		4:
			mob.position.x = 360
			mob.position.y = 240
			mob.rotation = PI/2
		5:
			mob.position.x = 360
			mob.position.y = 350
			mob.rotation = PI/2
		_:
			mob.position.x = 250
			mob.position.y = 240
			mob.rotation = 0
	add_child(mob)
	ran = randi() % 6
	# start timer for 1 second
	var _timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(true)
	_timer.start()

func _on_Timer_timeout():
	handleAnimations(ran)

func handleAnimations(num):
	$warningBottom.set_frame(0)
	$warningTop.set_frame(0)
	$warningLeft.set_frame(0)
	$warningRight.set_frame(0)
	match num:
		0:
			$warningBottom.animation = "left"
			$warningBottom.play()
			$warningTop.animation = "right"
			$warningTop.play()
		1:
			$warningBottom.animation = "middle"
			$warningBottom.play()
			$warningTop.animation = "middle"
			$warningTop.play()
		2:
			$warningBottom.animation = "right"
			$warningBottom.play()
			$warningTop.animation = "left"
			$warningTop.play()
		3:
			$warningRight.animation = "right"
			$warningRight.play()
			$warningLeft.animation = "left"
			$warningLeft.play()
		4:
			$warningRight.animation = "middle"
			$warningRight.play()
			$warningLeft.animation = "middle"
			$warningLeft.play()
		5:
			$warningRight.animation = "left"
			$warningRight.play()
			$warningLeft.animation = "right"
			$warningLeft.play()


func _on_startTimer_timeout():
	$mobTimer.start()
	$ScoreTimer.start()
	$warningBottom.animation = "middle"
	$warningBottom.play()
	$warningTop.animation = "middle"
	$warningTop.play()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
