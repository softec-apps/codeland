extends Control

var opcion : int
var select : bool
var can_slide : bool
var text_mundos={1:"Python",2:"Python\nPOO",3:"C++",4:"Java"}
onready var worlds=$CanvasLayer/Node2D/worlds
onready var world_icon=$CanvasLayer/Node2D/worlds/icon
onready var world_txt=$CanvasLayer/Node2D/worlds/world
onready var score=$CanvasLayer/Node2D/worlds/score
onready var menu=$CanvasLayer/Node2D/menu
onready var menu_txt=$CanvasLayer/Node2D/menu/menu_txt
onready var audio = $AudioStreamPlayer
onready var fondo=$CanvasLayer/Node2D/worlds/fondo

func _ready():
	worlds.visible=true
	menu.visible=false
	can_slide=true
	select=true
	opcion=1
	world_icon.frame=opcion-1
	world_txt.text=text_mundos[opcion]
	score.text=str(Global.WORLDS[opcion])
	$CanvasLayer/keyboard.play("space")
	bloquear()
	fondo_color()

func _process(_delta):
	Global.opcion=opcion
	cambio()
	opciones()
	anim_()
	if opcion==0:
		if Input.is_action_just_pressed("ui_select"):
			Transition.change_scene("res://GUI/Menu.tscn")
	elif opcion>=1:
		if Global.lock[opcion-1]:
			$CanvasLayer/bloqueo.visible=true
		else:
			$CanvasLayer/bloqueo.visible=false
		if Input.is_action_just_pressed("ui_select") and Global.lock[opcion-1]==false and select==true:
			select=false
			var level = "res://level/level"+str(opcion)+".tscn"
			var musica = load("res://assets/music/Chiptune Fun.wav")
			Transition.change_scene(level)
			MusicController.update_music(musica)

func opciones():
	if $CanvasLayer/Node2D.visible==false:
		if Global.opcion==0:
			select=true
			worlds.visible=false
			menu.visible=true
			$CanvasLayer/Node2D/menu/back.play("default")
		elif Global.opcion>=1:
			$CanvasLayer/Node2D/menu/back.stop()
			menu.visible=false
			worlds.visible=true
			score.text=str(Global.WORLDS[opcion])
			world_icon.frame=opcion-1
			world_txt.text=text_mundos[opcion]
		fondo_color()

func cambio():
	if Input.is_action_just_pressed("ui_right") and opcion<len(Global.WORLDS) and select==true and can_slide==true:
		opcion+=1
		$slide.play("slide_left")
		audio.play()
	elif Input.is_action_just_pressed("ui_left") and opcion>0 and select==true and can_slide==true:
		opcion-=1
		$slide.play("slide_rigth")
		audio.play()

func fondo_color():
	if opcion==1:
		fondo.modulate="41fff6"
	elif opcion==2:
		fondo.modulate="f6e557"
	elif opcion==3:
		fondo.modulate="ff7624"
	elif opcion==4:
		fondo.modulate="ffffff"

func anim_():
	if opcion==0:
		$CanvasLayer/right.visible=true
		$CanvasLayer/left.visible=false
	elif opcion==len(Global.WORLDS):
		$CanvasLayer/right.visible=false
		$CanvasLayer/left.visible=true
	elif opcion>=1 and opcion<len(Global.WORLDS):
		$CanvasLayer/right.visible=true
		$CanvasLayer/left.visible=true

func bloquear():
	Global.lock.clear()
	var i=1
	while i <= len(Global.WORLDS):
		if i==1:
			Global.lock.insert(i-1,false)
		elif i>1:
			if Global.WORLDS[i-1]>=70:
				Global.lock.insert(i-1,false)
			elif Global.WORLDS[i-1]<70:
				Global.lock.insert(i-1,true)
		i+=1

func _on_slide_animation_finished(_anim_name):
	can_slide=true


func _on_slide_animation_started(_anim_name):
	can_slide=false
