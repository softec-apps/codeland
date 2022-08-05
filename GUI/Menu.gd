extends Control

var opcion : int
var num = 1
var stream=load("res://assets/Menu_Sounds_Free/Menu_Sound_Hover.wav")
var select :bool
var can_slide
var textos = {1:"MUSIC", 2:"PLAY", 3:"EXIT"}
#nodos instanciados como variables para optimizacion
onready var opciones_menu=$CanvasLayer/buttons/opcion
onready var texto_opciones=$CanvasLayer/buttons/text
onready var animation=$AnimationPlayer
onready var audio = $AudioStreamPlayer
onready var buttons=$CanvasLayer/buttons


func _ready():
	SaveState.load_game()
	opcion=2
	select=true
	can_slide=true
	$teclas.play("space")
	opciones_menu.play("opcion"+str(opcion))
	texto_opciones.text=textos[opcion]

func _process(_delta):
	opciones()
	cambio()
	anim_()
	if Input.is_action_just_pressed("ui_select") and select==true:
		if opcion==1:
			MusicController.cambio()
		elif opcion==2:
			Transition.change_scene("res://GUI/Worlds.tscn")
			select=false
		elif opcion==3:
			get_tree().quit()

func opciones():
	if buttons.visible==false:
		opciones_menu.play("opcion"+str(opcion))
		texto_opciones.text=textos[opcion]

func anim_():
	if opcion==1:
		$CanvasLayer/right.visible=true
		$CanvasLayer/left.visible=false
	elif opcion==3:
		$CanvasLayer/right.visible=false
		$CanvasLayer/left.visible=true
	elif opcion>1 and opcion<3:
		$CanvasLayer/right.visible=true
		$CanvasLayer/left.visible=true

func cambio():
	if Input.is_action_just_pressed("ui_right") and opcion<3 and select==true and can_slide==true:
		animation.play("slide_left")
		audio.play()
		opcion+=1
	elif Input.is_action_just_pressed("ui_left") and opcion>1 and select==true and can_slide==true:
		opcion-=1
		animation.play("slide_rigth")
		audio.play()


func _on_AnimationPlayer_animation_finished(_anim_name):
	can_slide=true


func _on_AnimationPlayer_animation_started(_anim_name):
	can_slide=false
