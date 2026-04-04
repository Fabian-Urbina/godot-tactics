extends Node
class_name State

func Enter():
	AddListeners()

func Exit():
	RemoveListeners()
	
func _exit_tree():
	RemoveListeners()
	
func AddListeners():
	pass

func RemoveListeners():
	pass
