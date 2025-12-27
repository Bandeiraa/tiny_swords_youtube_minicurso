extends CharacterBody2D
class_name PersonagemBase

var _lista_de_armas: Array = [
	"_faca", "_machado", "_martelo", "_picareta"
]

var _indice_arma_atual: int = 0

var _arma_atual: String = ""
var _path_base: String = "res://personagens/peao/"

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
		set_process(false)
		
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
					
			get_tree().call_group("interface", "atualizar_indicador", _indice_arma_atual)
			_arma_atual = _lista_de_armas[_indice_arma_atual]
			
			
func _tratar_animacoes() -> void:
	if velocity.x > 0:
		_textura.flip_h = false
		
	elif velocity.x < 0:
		_textura.flip_h = true
		
	var _path_completo: String = ""
	
	if _posso_atacar == false:
		_path_completo = _path_base + "ataque" + _arma_atual + ".png"
		
		var _sufixo_animacao: String = ""
		match _arma_atual:
			"_machado", "_picareta":
				_sufixo_animacao = "_6f"
				
			"_faca":
				_sufixo_animacao = "_4f"
				
			"_martelo":
				_sufixo_animacao = "_3f"
				
		_animador.play("ataque" + _sufixo_animacao)
		
	elif velocity:
		_path_completo = _path_base + "andando" + _arma_atual + ".png"
		_animador.play("andando")
		
	else:
		_path_completo = _path_base + "parado" + _arma_atual + ".png"
		_animador.play("parado")
		
	_textura.texture = load(_path_completo)
	
	
func _quando_animacao_terminar(_anim_name: StringName) -> void:
	if _anim_name.contains("ataque"):
		_resetar_texturas()
		_posso_atacar = true
		set_process(true)
		
		
func _resetar_texturas() -> void:
	if velocity:
		_textura.hframes = 6
		_textura.texture = load(_path_base + "andando" + _arma_atual + ".png")
		
	else:
		_textura.hframes = 8
		_textura.texture = load(_path_base + "parado" + _arma_atual + ".png")
		
	_textura.frame = 0
