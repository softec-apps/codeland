extends Node2D

var Code = preload("res://elements/codes/code.tscn")
var Enemy = preload("res://elements/enemies/e001.tscn")

func _ready():
	randomize()
	Global.cont_code=1
	Global.cont_enemy=1
	Global.total=1

func _process(_delta):
	if Global.total<=18:
		spawn()

func spawn():
	if Global.cont_code<=10 and Global.cont_enemy<=8:
		var op=Global.random(1,2)
		if op==1:
			var code = Code.instance()
			add_child(code)
			code.position=$Position2D.position
			Global.cont_code+=1
		elif op==2:
			var enemy = Enemy.instance()
			add_child(enemy)
			enemy.position=$Position2D.position
			Global.cont_enemy+=1
		Global.total+=1
	elif Global.cont_code>10:
		var enemy = Enemy.instance()
		add_child(enemy)
		enemy.position=$Position2D.position
		Global.total+=1
	elif Global.cont_enemy>8:
		var code = Code.instance()
		add_child(code)
		code.position=$Position2D.position
		Global.total+=1
