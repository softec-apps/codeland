extends Camera2D

onready var player = get_tree().get_nodes_in_group("player")[0]
var is_outviewport=false
var play_once =1

func _ready():
	color_select()
	var checkpoint=get_tree().get_nodes_in_group("checkpoint")
	player.position=checkpoint[Global.check].position
	$Timer.start(200)
	Global.score=0
	$CanvasLayer/coin.play("default")
	$CanvasLayer/life.play("life")

func _process(_delta):
	#camara sigue a jugador
	global_position.x = player.global_position.x
	
	#textos del score y el tiempo restante
	$CanvasLayer/score.text=str(Global.score)
	$CanvasLayer/timer.text=str(int($Timer.time_left))
	$CanvasLayer/n_life.text="x"+str(player.vida)
	
	if player.is_win==true:
		$CanvasLayer/win.visible=true
		while play_once==1:
			$AnimationPlayer.play("title")
			play_once+=1
	else:
		$CanvasLayer/win.visible=false


func color_select():
	if Global.opcion==1:
		$ParallaxBackground/ParallaxLayer/Sprite.modulate="41fff6"
	elif Global.opcion==2:
		$ParallaxBackground/ParallaxLayer/Sprite.modulate="f6e557"
	elif Global.opcion==3:
		$ParallaxBackground/ParallaxLayer/Sprite.modulate="ff7624"
	elif Global.opcion==4:
		$ParallaxBackground/ParallaxLayer/Sprite.modulate="ffffff"


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if player.vida>1:
			player.vida-=1
			player.respawn()
		else:
			player.vida=0
			player.die()


func _on_Timer_timeout():
	$Timer.stop()
	player.vida=0
	player.die()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="title":
		$AnimationPlayer.stop()
