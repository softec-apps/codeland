extends Node

var score : int
var max_score = 0
var check=0
var rng :RandomNumberGenerator = RandomNumberGenerator.new()
var cont_code=1
var cont_enemy=1
var total=1
var opcion=1
var lock=[]
var WORLDS ={
	1:0,
	2:0,
	3:0,
	4:0,
	}

func random(min_value, max_value):
	rng.randomize()
	var n_random = rng.randi_range(min_value, max_value)
	return n_random

func update_score(mundo):
	var actual = max_score
	if score > actual:
		max_score = score
	WORLDS[mundo]=max_score
	return WORLDS[mundo]
