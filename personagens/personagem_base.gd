extends CharacterBody2D
class_name PersonagemBase

var _lista_de_armas: Array = [
	"_faca", "_machado", "_martelo", "_picareta"
]

var _indice_arma_atual: int = 0
var _arma_atual: String = ""

var _posso_atacar: bool = true

@export_category("Objetos")
@export var _textura: Sprite2D = null
@export var _animador: AnimationPlayer = null

@export_category("Variaveis")
@export var _velocidade_de_movimento: float = 256.0

func _ready() -> void:
	_arma_atual = _lista_de_armas[_indice_arma_atual]
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ataque") and _posso_atacar:
		_posso_atacar = false
		_tratar_animacoes()
		
	if _posso_atacar == false:
		return
		
	var _direcao: Vector2 = Input.get_vector(
		"mover_esquerda", "mover_direita",
		"mover_cima", "mover_baixo"
	)
	
	velocity = _direcao * _velocidade_de_movimento
	move_and_slide()
	
	_tratar_animacoes()
	
	
func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		if _event.is_pressed():
			if _event.button_index == 4:
				if _indice_arma_atual == _lista_de_armas.size() - 1:
					_indice_arma_atual = 0
					
				else:
					_indice_arma_atual += 1
					
			elif _event.button_index == 5:
				if _indice_arma_atual == 0:
					_indice_arma_atual = _lista_de_armas.size() - 1
					
				else:
					_indice_arma_atual -= 1
					
			_arma_atual = _lista_de_armas[_indice_arma_atual]
			
			
func _tratar_animacoes() -> void:
	if velocity.x > 0:
		_textura.flip_h = false
		
	elif velocity.x < 0:
		_textura.flip_h = true
		
	var _path_base: String = "res://personagens/peao/"
	var _path_completo: String = ""
	
	if _posso_atacar == false:
		_path_completo = _path_base + "ataque" + _arma_atual + ".png"
		_animador.play("ataque")
		
	elif velocity:
		_path_completo = _path_base + "andando" + _arma_atual + ".png"
		_animador.play("andando")
		
	else:
		_path_completo = _path_base + "parado" + _arma_atual + ".png"
		_animador.play("parado")
		
	_textura.texture = load(_path_completo)
