extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_player_pieces(nb):
	set_text("Coins : " + str(nb) + " / 7")
