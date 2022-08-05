extends RayCast2D



func _ready():
	enabled=true

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.check=0
		Transition.change_scene("res://GUI/Worlds.tscn")
		musica()
	if is_colliding():
		var body = get_collider()
		enabled=false
		var codes=get_tree().get_nodes_in_group("code")
		var enemies=get_tree().get_nodes_in_group("enemy")
		for i in codes:
			i.queue_free()
		for i in enemies:
			i.queue_free()
		Global.check=0
		body.can_move=false
		body.win()

func musica():
	var soundtrack = load("res://assets/music/8-Bit Party Dance.wav")
	MusicController.update_music(soundtrack)


func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible=true
	$AnimatedSprite.play("default")
	enabled=true


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	$AnimatedSprite.stop()
	visible=false
	enabled=false
