extends KinematicBody2D

onready var player = get_tree().get_nodes_in_group("player")[0]
var movimiento = Vector2.ZERO
export var velocidad = 0
export var gravedad = 0
var can_move : bool
var codigo_mundo1={1: '(1<2)&&(3>2)',2: '(var1)||(var2)',3: '!variable',4:'void mi_funcion(){}',5:'if condicion{}',
6:'else{}',7:'else{\n	if cond{}}',8:'for(i=0;1<=5;i++){}',9:'try{}\ncatch(error){}',10:'printf("Hola");',
11:'int num = 4;\nString change= String.valueOf(num);'}
var codigo_mundo2={1:'public class objeto{}',2:'public valor(int v1){\nvalor=v1;}',3:'myObject = null;',4:'#import modulo',5:'Desde modulo import clase',
6:'Clase nombre_objeto(arg1,..., argn);'}
var codigo_mundo3={1:'for i in opcion:\nprint(i)',2:'try:\nexcept:',3:'array = []',4:'matriz=[\n[1,2,3],\n[8,2,0],]',5:'System.printf("I choose you");',
6:'print("Here we go again")',7:'erase objeto;',8:'public static void texto(String tx){}',9:'public static void Main(String[] args) {}',10:'ptr __new__ :'}
var codigo_mundo4={1:'public main(){\n}',2:'public asbtractmethod void {\n}',3:'class B: extends A',4:'private class {\n}',5:'printf("One point");',
6:'str texto="ABC..',7:'Public void Person{\nthis.name=name;}',8:'num=1;\nnumCadena=str(num);',9:'len(opcion)',10:'#include<iostream>'}
var MUNDOS={1: codigo_mundo1,2: codigo_mundo2,3: codigo_mundo3,4:codigo_mundo4}

func _ready():
	generar_txt()

func _process(_delta):
	move_ctrl()
	if player.is_win==true:
		can_move=false

func move_ctrl():
	movimiento.y += gravedad
	if is_on_floor():
		movimiento.y=0
	if can_move:
		$AnimatedSprite.play("walk")
		flip()
	elif !can_move:
		movimiento.x=0
	return move_and_slide(movimiento,Vector2.UP)


func floor_detection() -> bool:
	return $AnimatedSprite/RayFloor.is_colliding()
func der_detection() -> bool:
	return $AnimatedSprite/RayRight.is_colliding()

func flip():
	movimiento.x = -velocidad
	can_move=true
	if(der_detection() or !floor_detection()):
		$AnimatedSprite.scale.x *= -1
		velocidad*=-1

func muerte():
	can_move=false
	remove_from_group("enemy")
	$AnimatedSprite.play("delete")

func generar_txt():
	var mundo = MUNDOS[Global.opcion]
	var opcion=Global.random(1,len(MUNDOS[Global.opcion]))
	$Label.text=mundo[opcion]


func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible=true
	can_move=true


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	visible=false
	can_move=false


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="delete":
		queue_free()
