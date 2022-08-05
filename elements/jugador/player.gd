extends KinematicBody2D

var movimiento = Vector2.ZERO
var direccion = Vector2.ZERO
var distancia=Vector2.ZERO
export var velocidad = 0
export var gravedad = 0
export var f_salto = 0
export var BOUNCING_JUMP=0
export var resbalar:bool
var Ray_wall=true
var vida = 3
var detectar = false
var cuerpo
var can_move : bool
var is_win = false
var stream
var time_to_respawn=false
onready var audio = $AudioStreamPlayer2D
onready var animated=$AnimatedSprite


func _ready():
	can_move=false
	set_physics_process(true)

func _physics_process(delta):
	move_CTRL(delta)
	animation()

#verificar si el jugador se encuentra colisionando y quitarle una vida
	if detectar==true:
		if cuerpo.is_in_group("enemy"):
			life()
			cuerpo.muerte()
			if vida>0:
				audio.stream=load("res://assets/sounds/Classic Gaming Hit 01.wav")
				audio.play()
				$Timer.start(1)
				$Area2D/CollisionShape2D.disabled=true #deshabilitar la colision durante 2 segundos
				animated.play("hurt")
				detectar=false

func move_CTRL(delta):
	movimiento.y+=gravedad*delta
	if can_move==true:
		direccion.x=int (Input.is_action_pressed("ui_right"))- int (Input.is_action_pressed("ui_left"))
		distancia.x = velocidad*delta
		movimiento.x=(direccion.x * distancia.x)/delta
		if is_on_floor():
			Ray_wall=true
			movimiento.y=0
			if Input.is_action_pressed("ui_select"):
				movimiento.y=-f_salto
				audio.stream=load("res://assets/sounds/Jumps.wav")
				audio.play()
		if is_on_ceiling():
			movimiento.y=0
			movimiento.y+=gravedad*delta
		if movimiento.x<0:
			animated.flip_h=true
		elif movimiento.x>0:
			animated.flip_h=false
		if is_on_wall() and  Ray_wall and !is_on_floor():
			if Input.is_action_just_pressed("ui_select") :
				movimiento.y=-BOUNCING_JUMP
				audio.stream=load("res://assets/sounds/Jumps.wav")
				audio.play()
				Ray_wall=false
		else:
			Ray_wall=true
	else:
		movimiento.x=0
	
	return move_and_slide(movimiento,Vector2.UP)


func animation():
	if can_move==true:
		if movimiento.x<0 or movimiento.x>0:
			animated.play("run")
		else:
			animated.play("idle")
		if !is_on_floor():
			if movimiento.y<0:
				animated.play("jump")
			elif movimiento.y>0:
				animated.play("falling")
	if vida<=0:
		can_move=false
		gravedad=0
		animated.play("die")

func respawn():
	time_to_respawn=false
	Transition.reload()
	can_move=false
	$Timer.start()

func spawn():
	Transition.change_scene("res://GUI/Worlds.tscn")
	var soundtrack= load("res://assets/music/8-Bit Party Dance.wav")
	MusicController.update_music(soundtrack)
	Global.check=0

func die():
	audio.stream=load("res://assets/sounds/Chiptune Fail Game 05.wav")
	audio.play()

func life():
	vida -=1
	can_move=false
	if vida<=0:
		die()

func win():
	is_win=true
	animated.play("win")
	audio.stream=load("res://assets/sounds/Chiptune Victory 02.wav")
	audio.play()

#deteccion del enemigo
func _on_Area2D_body_entered(body):
	detectar=true
	cuerpo=body
	if body.is_in_group("code"):
		Global.score+=10
		body.point()
		audio.stream=load("res://assets/sounds/Games Retro Award.wav")
		audio.play()


func _on_Area2D_body_exited(_body):
	detectar=false


func _on_Timer_timeout():
	$Timer.stop()
	$Area2D/CollisionShape2D.disabled=false
	can_move=true
	time_to_respawn=true


func _on_AnimatedSprite_animation_finished():
	if animated.animation=="die":
		spawn()
	elif animated.animation=="win":
		var actual_score = SaveState.data["worlds_score"]
		if Global.score>actual_score[Global.opcion]:
			Global.update_score(Global.opcion)
			SaveState.save_data()
		Transition.change_scene("res://GUI/Worlds.tscn")
		var soundtrack= load("res://assets/music/8-Bit Party Dance.wav")
		MusicController.update_music(soundtrack)
