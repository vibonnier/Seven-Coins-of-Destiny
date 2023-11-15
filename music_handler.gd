extends Control

var normal
var defeat
var victory


func _ready():
	var player = load("res://MusicPlayer.tscn")
	normal = player.instance()
	add_child(normal)
	normal.set_stream(load("res://sound/music.wav"))
	normal.set_bus("Master")
	defeat = player.instance()
	add_child(defeat)
	defeat.set_stream(load("res://sound/music-sololess.wav"))
	victory = player.instance()
	add_child(victory)
	victory.set_volume_db(-45)
	victory.set_stream(load("res://sound/music-victory.wav"))
	victory.play()
	normal.play()
	defeat.play()
	PlayDefeat()


func PlayNormal():
	normal.set_bus("Master")
	defeat.set_bus("Silent")
	victory.set_bus("Silent")


func PlayDefeat():
	normal.set_bus("Silent")
	defeat.set_bus("Master")
	victory.set_bus("Silent")


func PlayVictory():
	normal.set_bus("Silent")
	defeat.set_bus("Silent")
	victory.set_bus("Master")
