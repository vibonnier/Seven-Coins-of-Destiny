extends Sprite


export var anim_offset = Vector2()
export var globalposition = Vector2()


func _ready():
	$AnimationPlayer.play("deplacement")


func _physics_process(delta):
	position=anim_offset + globalposition


# The player dies if enter in collision with the pics.
func _on_hitbox_body_entered(body):
	body.gameover()


# If the player dash on the pics, delete them.
func _on_player_dashing(cellposition):
	if abs(position.x-cellposition)<32 and position.y<-26:
		queue_free()
