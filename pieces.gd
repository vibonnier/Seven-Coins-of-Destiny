extends Sprite


signal taking(id)
export var id = 0


func _ready():
	if id in Global.piece:
		queue_free()


# When the player take a coin, it delete it and save its id.
func _on_hitbox_body_entered(body):
	if not body is KinematicBody2D:
		return
	body.taking(id)
	print('You take a coin!')
	$AudioStreamPlayer.play()
	queue_free()
