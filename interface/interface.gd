extends CanvasLayer
class_name Interface

func atualizar_indicador(_indice_do_slot: int) -> void:
	for _slot in $Avatar/ContainerSlots.get_children():
		_slot.get_node("Indicador").hide()
		
	$Avatar/ContainerSlots.get_child(_indice_do_slot).get_node("Indicador").show()
