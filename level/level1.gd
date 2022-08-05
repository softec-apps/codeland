extends Node2D

onready var animation=$AnimationPlayer
onready var sprite=$Sprite

func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	sprite.visible=true
	animation.play("wall_jump")


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	sprite.visible=false
	animation.stop()
