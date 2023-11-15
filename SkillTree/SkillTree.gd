extends Control


var skillpoints=2


func _ready():
	if Global.piece_now == 7:
		$Text.queue_free()
		$Victory.show()
	$BoxContainer/Start.grab_focus()


# Enter in the skills Tree.
func _on_Start_pressed():
	$BoxContainer.queue_free()
	$Text.queue_free()
	$Victory.queue_free()
	$Skills.show()
	$Skills/Possibilities/saut/Button.grab_focus()


# Quit the game.
func _on_Quit_pressed():
	get_tree().quit()


# Reduce the skill points or start the game.
func _on_Control_dimskill():
	if skillpoints == 2:
		skillpoints = 1
		$"Skills/Skillpoints/number of skill point".set_text(str(1))
	else:
		get_tree().change_scene("res://tilemap.tscn")


# Open the skill possibilities after "nage".
func _on_nage_nagepris():
	$Skills/Possibilities/dash.availible()
	$Skills/Possibilities/oxy.availible()


# Open the skill possibilities after "saute".
func _on_saut_sautpris(): 
	$Skills/Possibilities/double.availible()
	$Skills/Possibilities/para.availible()
