extends KinematicBody2D


var vel = Vector2()
var speed = 200
const gravity = -1000
export var saut = false
export var nage = false
export var double = false
export var parachute = false
export var oxygene = false
export var dash = false
var numberofjump = 0
export var ox_max = 700
var ox_now = ox_max
var piece_now = 0
var piece = []
var look_left = false
onready var anim = get_child(0)
onready var audiofilter

signal dashing(cellposition)
signal parachuting
signal sauting
signal pieces(nb)
signal oxygene(nb)


func _ready():
	randomize()
	nage = Global.nage
	saut = Global.saut
	double = Global.double
	parachute = Global.parachute
	dash = Global.dash
	oxygene = Global.oxygene
	piece_now = Global.piece_now
	piece = Global.piece.duplicate()
	emit_signal("pieces",piece_now)
	audiofilter = AudioServer.get_bus_effect(0,0)


# Put a filter to the music in water.
func FilterAudio():
	if position.y  < - 25:
		audiofilter.set_cutoff(2)
	elif position.y < 0:
		audiofilter.set_cutoff(60*(position.y + 25) + 2)
	else:
		 audiofilter.set_cutoff(4*(position.y) + 1500)
	
	
# Fluidize the mouvment.
func _physics_process(delta):
	movement(delta)
	move_and_slide(vel,Vector2(0,-1))
	jumpreset()
	FilterAudio()
	if position.x >1280:
		victory()


# Can rejump after hit the floor.
func jumpreset():
	if is_on_floor() or position.y >= -26 :
		numberofjump = 0


func gameover():
	MusicHandler.PlayDefeat()
	$Node.get_child(randi() % 2).play()
	reinit()

func reinit():
	Global.reinit()
	get_tree().change_scene("res://SkillTree/SkillTree.tscn")


func victory():
	Global.piece=piece.duplicate()
	Global.piece_now=piece_now
	MusicHandler.PlayVictory()
	reinit()


func sauter():
		numberofjump += 1
		if numberofjump == 1:
			$jump.get_child(randi() % 3).play()
		else:
			$doublejump.get_child(randi() % 2).play()
		vel.y = -speed*2.3
		emit_signal("sauting")


func respirer(delta):
	ox_now -= 100 * delta
	if ox_now < 0:
		gameover()
	emit_signal("oxygene", floor(ox_now/100+1))


func reprendre_souffle():
	ox_now = ox_max
	emit_signal("oxygene", floor(ox_now/100+1))


func dash():
	$dash.get_child(randi() % 3).play()
	if look_left and position.x > 64:
		emit_signal("dashing", position.x - 64)
		position.x -= 64
	elif not look_left:
		emit_signal("dashing", position.x + 64)
		position.x += 64


# Take the coins.
func taking(id):
	print(id)
	piece_now += 1
	piece.append(id)
	$coin.play()
	emit_signal("pieces",piece_now)
	


func movement(delta):
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var dirx = int(right) - int(left)
	var jump = Input.is_action_just_pressed("ui_accept")
	var dashed = Input.is_action_just_pressed("ui_select")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var diry = int(down) - int(up)
	
	if is_on_floor():
		vel.y = 0
	
	elif  is_on_floor() == false and numberofjump == 0 and position.y < - 64:
		numberofjump = 1
	
	
	if jump:
		if numberofjump == 0  and saut:
			sauter()
		elif numberofjump < 2 and double:
			sauter()
	
	
	if position.y < -32:
		if parachute and Input.is_action_pressed("ui_accept") and vel.y > 0:
			vel.y -= gravity/10*delta
			emit_signal("parachuting")
		else:
			vel.y -= gravity*delta
		reprendre_souffle()
	
	elif position.y > -32:
		if dashed and dash:
			dash()
		if position.y > -26:
			if not oxygene:
				vel.y += gravity /100
			else:
				if position.y < -24:
					reprendre_souffle()
				else:
					respirer(delta)
				if diry == -1:
					vel.y = - speed
				elif diry == 1:
					vel.y = speed
				else:
					vel.y = 0
			vel = vel*0.7
			if nage==false:
				gameover()
		else:
			vel.y = vel.y*0.95
	
	
	if dirx == -1:
		vel.x = - speed
		look_left = true
	elif dirx == 1:
		vel.x = speed
		look_left = false
	else:
		vel.x = 0
	
	
	$AnimatedSprite.set_flip_h(look_left)
	
	

	
	
