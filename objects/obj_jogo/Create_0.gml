// Lista de produtos
produtos = []

base_y = 80
produtos_y = 0 + base_y

cria_produtos = function(_qtd = 1) {
	for (var i = 0; i < _qtd; i++){
		
		// struct com meus dados
		var _struct = {
			indice : i,
			custo_base : i + 4
		}
		
		produtos[i] = instance_create_layer(0, 0, layer, obj_produto, _struct)
		with(produtos[i]){
			indice	   = i
			tempo	   = i + 1
			custo	   = custo_base
			lucro_base = i + 1
		}
	}
}

rolagem_produtos = function() {
	if (keyboard_check(vk_up)){
		produtos_y -= 10
	}
	if (keyboard_check(vk_down)) {
		produtos_y += 10
	}
	
	// Descobrindo valor maximo da rolagem para cima
	var _qtd = array_length(produtos)
	var _max = (96 * _qtd) + (20 * _qtd) + 20 - room_height
	
	// limitando rolagem de produtos
	produtos_y = clamp(produtos_y, -_max, base_y)	
}

rolagem = function(_val = 10){
	var _qtd = 0
	
	// Rolando com o scroll
	if (mouse_wheel_down()) {
		_qtd = -_val
	}
	if (mouse_wheel_up()) {
		_qtd = _val
	}
	
	return _qtd
}

gerencia_produtos = function() {
	static _meu_y = 0
	var _alt = sprite_get_height(spr_produto)
	var _larg = sprite_get_width(spr_produto)
	var _marg = 20
	_meu_y += rolagem(30)
	
	// limite de scroll
	var _qtd = array_length(produtos)
	var _max = (_alt * _qtd + (_marg * _qtd) + _marg - room_height)
	_meu_y = clamp(_meu_y, -_max, 0)
	//rolagem_produtos()
	
	for (var i = 0; i < array_length(produtos); i++){
		var _x = 160
		var _y = _meu_y + _marg + ((i * _alt) + (i * _marg))
		
		with(produtos[i]){
			x = _x
			y = _y + sprite_height/2
		}
	}
}

cria_produtos(10)