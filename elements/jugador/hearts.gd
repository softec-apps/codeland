extends Area2D

func _ready():
	$AnimatedSprite.stop()

func _on_hearts_body_entered(body):
	if body.is_in_group("player") and body.vida<3 and body.vida>0:
		body.vida+=1
		$AudioStreamPlayer2D.play()
		$AnimatedSprite.play("delete")



func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible=true
	$AnimatedSprite.play("default")


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	visible=false
	$AnimatedSprite.stop()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="delete":
		queue_free()
