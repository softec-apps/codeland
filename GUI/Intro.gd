extends Control

onready var tutorial = $CanvasLayer/Node2D/tutorial
onready var intro = $AnimationPlayer
onready var funciones=$CanvasLayer/Node2D/funciones


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Transition.change_scene("res://GUI/Menu.tscn")
		MusicController._play()


func _ready():
	tutorial.stop()
	tutorial.visible=false
	intro.play("intro")

func _on_AnimationPlayer_animation_finished(_anim_name):
	tutorial.play("izq")
	funciones.rect_position=Vector2(320,400)
	funciones.text="Deslizar y caminar a la izquierda"
	tutorial.visible=true


func _on_tutorial_animation_finished():
	if tutorial.animation=="izq":
		funciones.rect_position=Vector2(400,400)
		funciones.text="Seleccionar y saltar"
		tutorial.play("space")
	elif tutorial.animation=="space":
		funciones.rect_position=Vector2(330,400)
		funciones.text="Deslizar y caminar a la derecha"
		tutorial.play("der")
	elif tutorial.animation=="der":
		Transition.change_scene("res://GUI/Menu.tscn")
		MusicController._play()
