extends Node


enum Skillset {nage,saut,doublesaut,parachute,dash,plonge}
var nage = false
var saut = false
var double = false
var parachute = false
var dash = false
var oxygene = false
var piece_now = 0
var piece = []


func reinit():
	nage = false
	saut = false
	double = false
	parachute = false
	dash = false
	oxygene = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


func make_true(skill):
	match skill:
		Skillset.nage:
			nage = true
		Skillset.saut:
			saut = true
		Skillset.doublesaut:
			double = true
		Skillset.parachute:
			parachute = true
		Skillset.dash:
			dash = true
		Skillset.plonge:
			oxygene = true
