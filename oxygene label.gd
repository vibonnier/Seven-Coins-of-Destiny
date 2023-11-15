extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_player_oxygene(nb):
	set_text("Oxygen : " + str(nb))
