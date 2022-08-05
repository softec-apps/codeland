extends CanvasLayer

var fordward = load("res://assets/Menu_Sounds_Free/Menu_Sound_Forward.wav")
var backward = load("res://assets/Menu_Sounds_Free/Menu_Sound_Backward.wav")
onready var audio=$AudioStreamPlayer
onready var animation=$AnimationPlayer


func reload():
	audio.stream=fordward
	audio.play()
	animation.play("close")
	yield(animation,"animation_finished")
	audio.stream=backward
	audio.play()
	var checkpoint=get_tree().get_nodes_in_group("checkpoint")
	checkpoint[Global.check-1].respawn()
	animation.play("open")

func change_scene(scene):
	audio.stream=fordward
	audio.play()
	animation.play("close")
	yield(animation,"animation_finished")
	var cambio=get_tree().change_scene(scene)
	audio.stream=backward
	audio.play()
	animation.play("open")
	return cambio
