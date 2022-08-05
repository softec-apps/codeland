extends Node

var is_play = true
var soundtrack = load("res://assets/music/8-Bit Party Dance.wav")
onready var audio=$AudioStreamPlayer


func _play():
	music(soundtrack)


func update_music(musica):
	audio.stop()
	audio.stream=musica
	music(musica)

func cambio():
	if is_play == true:
		is_play = false
		music(soundtrack)
	elif is_play==false:
		is_play = true
		music(soundtrack)

func music(musica):
	if is_play == true:
		audio.stream = musica
		audio.play()
	else:
		audio.stop()

func _on_AudioStreamPlayer_finished():
	if is_play == true:
		audio.play()
