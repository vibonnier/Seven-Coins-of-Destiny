extends TileMap


func _ready():
	MusicHandler.PlayNormal()


func gameover():
	pass 


func taking(id):
	pass


# Delete the tilemap if the player dashing on.
func _on_player_dashing(cellposition):
	if cellposition > 0 and cellposition < 1216:
		set_cell(floor(cellposition/64),-1,3)
