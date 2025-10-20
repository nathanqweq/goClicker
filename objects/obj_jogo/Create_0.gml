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

gerencia_produtos = function() {
	
	rolagem_produtos()
	
	for (var i = 0; i < array_length(produtos); i++){
		var _marg = 20
		var _x = 160
		var _y = produtos_y + _marg + ((i * 96) + (i * _marg))
		
		with(produtos[i]){
			x = _x
			y = _y + sprite_height/2
		}
	}
}

cria_produtos(10)