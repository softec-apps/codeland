extends KinematicBody2D

onready var player = get_tree().get_nodes_in_group("player")[0]
var movimiento = Vector2.ZERO
export var velocidad = 0
export var gravedad = 0
var masa = 4
var can_move : bool
var codigo_mundo1={1: '(1<2)and(3>2)',2: '(var1)or(var2)',3: 'not variable',4:'def mi_funcion():',5:'if cond:',
6:'else:',7:'elif not cond:',8:'for i in var:',9:'try:\nexcept:',10:'print("Hola")',11:'int num1=3\nstr(num1)'}
var codigo_mundo2={1:'class objeto():',2:'def __init__(self):',3:'del object_name',4:'import modulo1',5:'from mimodulo import objeto',
6:'ob1=Objeto(atributos)'}
var codigo_mundo3={1:'for(int i=0;1<=5;i++){\nprintf("i");}',2:'try{}\ncatch(error){}',3:'int array[n];',4:'int A[3][3];',5:'cout << "Hola";',
6:'cin >> valor;',7:'delete objeto;',8:'static int num=1;',9:'#include<iostream.h>\nint main(){return 0;}',10:'ptr = new int;\n*ptr=10'}
var codigo_mundo4={1:'public static void Main(String[] args) {}',2:'public abstract class figura{\n}',3:'public class B extends A{\n}',4:'public class Car implements motor',5:'System.out.println("You can do this");',
6:'String texto1="ABC..";',7:'Public void Person(String name){\nthis.name=name;}',8:'int num=Integer.parseInt(Cadena);',9:'length(opcion1);',10:'import java.util.Scanner;'}
var MUNDOS={1: codigo_mundo1,2: codigo_mundo2,3: codigo_mundo3,4:codigo_mundo4}

func _ready():
	generar_txt()
	$AnimatedSprite.play("walk")

func _physics_process(_delta):
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
	return move_and_slide(movimiento, Vector2.UP)


func floor_detection() -> bool:
	return $AnimatedSprite/RayFloor.is_colliding()
func der_detection() -> bool:
	return $AnimatedSprite/RayRight.is_colliding()

func flip():
	movimiento.x = -velocidad
	if(der_detection() or !floor_detection()):
		$AnimatedSprite.scale.x *= -1
		velocidad*=-1

func point():
	can_move=false
	remove_from_group("code")
	$AudioStreamPlayer2D.play()
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
