extends Node2D

onready var player=get_tree().get_nodes_in_group("player")[0]
export var is_checkpoint : bool
var check=false


func _process(_delta):
	anim()
	new_checkpoint()


func anim():
	if is_checkpoint==true:
		$Sprite.visible=true
	else:
		$Sprite.visible=false


func new_checkpoint():
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		$RayCast2D.enabled=false
		collider.can_move=true
		Global.check+=1
		check=true
		if is_checkpoint:
			$AudioStreamPlayer2D.play()
			$AnimationPlayer.play("activated")


func respawn():
	player.global_position=$Position2D.global_position


func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible=true
	if check==false:
		$AnimationPlayer.play("no_activated")


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	visible=false
	$AnimationPlayer.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="activated":
		$AnimationPlayer.stop()
