extends Control


signal dimskill
signal sautpris
signal nagepris
enum Skillset {nage,saut,doublesaut,parachute,dash,plonge}
export(Skillset) var skill
export var active = false
onready var aval = get_node("avalible")
onready var b = get_node("Button")


# Called when the node enters the scene tree for the first time.
func _ready():
	if active:
		availible()
	if skill == Skillset.saut:
		$logo.set_frame(1)
		b.set_tooltip("jump")
	if skill == Skillset.doublesaut:
		$logo.set_frame(1)
		b.set_tooltip("double jump. NEEDED: jump")
	if skill == Skillset.parachute:
		$logo.set_frame(7)
		b.set_tooltip("float in the air. NEEDED: jump")
	if skill == Skillset.nage:
		$logo.set_frame(4)
		b.set_tooltip("swim")
	if skill == Skillset.dash:
		$logo.set_frame(6)
		b.set_tooltip("dash. NEEDED: swim")
	if skill == Skillset.plonge:
		$logo.set_frame(4)
		b.set_tooltip("div under water. NEEDED: swim")


# Open the possibilities.
func availible():
	aval.show()
	b.set_disabled(false)


# Activate the choosen skills.
func activated():
	$activ.show()
	$Button.set_disabled(true)


# Send signal to choose and activate.
func rendre_dispo():
	match skill:
		Skillset.saut:
			emit_signal("sautpris")
			print("You choose the jump")
		Skillset.nage:
			emit_signal("nagepris")
			print("You choose swim")


# Change the color state if choosen.
func _process(_delta):
	match $Button.has_focus():
		true: $ColorRect.show()
		false: $ColorRect.hide()


# Put all together.
func _on_Button_pressed():
	emit_signal("dimskill")
	Global.make_true(skill)
	activated()
	rendre_dispo()
