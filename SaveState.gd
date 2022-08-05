extends Node

var data={
	"worlds_score":Global.WORLDS,
}

const SAVE_DIR = "user://saves/"

#Una variable que guarda la ruta y nombre del archivo de guardado
var save_path = SAVE_DIR+"save.dat"

func save_game():
	var dir=Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new() # variable donde guardar archivo}
	var error= file.open(save_path,File.WRITE)
	if error==OK:
		file.store_var(data)
		file.close()


func save_data():
	data["worlds_score"]=Global.WORLDS
	save_game()



func load_game():
	var file = File.new() # Instanciamos un File
	if file.file_exists(save_path): # Nos aseguramos que el archivo a leer existe
		var error=file.open(save_path,File.READ)
		if error == OK:
			data=file.get_var()
			Global.WORLDS=data["worlds_score"]
			file.close()
