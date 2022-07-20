extends RigidBody2D





func _ready():
	$AnimatedSprite.set_frame(0)
	$Last.start()
	$AnimatedSprite.play()



#func _process(delta):
#	pass


func _on_Last_timeout():
	queue_free()
