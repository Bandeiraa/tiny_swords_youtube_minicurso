extends CharacterBody2D
class_name PersonagemBase

@export_category("Objetos")
@export var _textura: Sprite2D = null
@export var _animador: AnimationPlayer = null

@export_category("Variaveis")
@export var _velocidade_de_movimento: float = 256.0

func _process(_delta: float) -> void:
	var _direcao: Vector2 = Input.get_vector(
		"mover_esquerda", "mover_direita",
		"mover_cima", "mover_baixo"
	)
	
	velocity = _direcao * _velocidade_de_movimento
	move_and_slide()
	
	_tratar_animacoes()
	
	
func _tratar_animacoes() -> void:
	if velocity.x > 0:
		_textura.flip_h = false
		
	elif velocity.x < 0:
		_textura.flip_h = true
		
	if velocity:
		_animador.play("andando")
	else:
		_animador.play("parado")
