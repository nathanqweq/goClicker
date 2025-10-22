// Lista de produtos
produtos = []
managers = []

// Dados da minha surface de produtos
surf_prod   = noone
surf_prod_w = 850
surf_prod_h = 500
surf_prod_x = 48
surf_prod_y = 48

// dados da surface managers
surf_mana   = noone
surf_mana_w = 360
surf_mana_h_base = 500
surf_mana_h = 1
surf_mana_x = 880
surf_mana_y = 48

base_y = 80
produtos_y = 0 + base_y

cria_produtos = function(_qtd = 1) {
	for (var i = 0; i < _qtd; i++){
		// struct com meus dados json
		var _struct = global.struct_produtos[i]
		produtos[i] = instance_create_layer(0, 0, layer, obj_produto, _struct)
	}
}

cria_managers = function() {
	// 1 manager para cada produto
	for (var i = 0; i < array_length(produtos); i++) {
		var _meu_produto = i
		managers[i] = instance_create_layer(900, 100 + i * 100, layer, obj_manager)
		
		managers[i].custo = global.produtos[i].custo_base*9
		managers[i].indice = i
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

rolagem = function(_val = 10, _x=0, _y=0, _w=0, _h=0){
	var _qtd = 0
	var _fazer = false
	
	if (_w != 0) {
		_fazer = point_in_rectangle(mouse_x, mouse_y, _x, _y, _x+_w, _y+_h)
	}
	
	if (_fazer){
		// Rolando com o scroll
		if (mouse_wheel_down()) {
			_qtd = -_val
		}
		if (mouse_wheel_up()) {
			_qtd = _val
		}
	}
	
	return _qtd
}

gerencia_managers = function () {
	static _meu_y = 0
	var _alt = sprite_get_height(spr_produto)
	var _larg = sprite_get_width(spr_produto)
	var _marg = 20
	_meu_y += rolagem(30, surf_mana_x, surf_mana_y, surf_mana_w, surf_mana_h)
	
	// limite de scroll
	var _qtd = array_length(managers)
	var _max = (_alt * _qtd) + (_marg * _qtd) + _marg - surf_prod_h
	_meu_y = clamp(_meu_y, -_max, 0)

	for (var i = 0; i < _qtd; i++) {
		var _x = 0
		var _y = _meu_y + _marg + ((i * _alt) + (i * _marg))
		
		with(managers[i]){
			x = _x
			y = _y + sprite_height / 2
		}
	}
}

gerencia_produtos = function() {
	static _meu_y = 0
	var _alt = sprite_get_height(spr_produto)
	var _larg = sprite_get_width(spr_produto)
	var _marg = 20	
	_meu_y += rolagem(30, surf_prod_x, surf_prod_y, surf_prod_w/2, surf_prod_h)
	
	// limite de scroll
	var _qtd = array_length(produtos)
	var _max = (_alt * _qtd) + (_marg * _qtd) + _marg - surf_prod_h
	_meu_y = clamp(_meu_y, -_max, 0)
	//rolagem_produtos()
	
	for (var i = 0; i < array_length(produtos); i++){
		var _x = 24
		var _y = _meu_y + _marg + ((i * _alt) + (i * _marg))
		
		with(produtos[i]){
			x = _x
			y = _y + sprite_height/2
		}
	}
}

desenha_managers = function() {
	
	// mudando tamanho da surface com base na global exibe managet
	
	if (global.exibe_managers){
		surf_mana_h = lerp(surf_mana_h, surf_mana_h_base, .1)
	} else {
		surf_mana_h = lerp(surf_mana_h, 1, .1)
	}
	
	if (surface_exists(surf_mana)) {
		// configura surface
		surface_set_target(surf_mana)
		draw_clear_alpha(c_black, 0)
		draw_rectangle_color(0, 0, surf_mana_w, surf_mana_h, c_black, c_black, c_black, c_black, false)
		
		if (surf_mana_h > 3){
			with(obj_manager) {
				desenha_manager()
				meu_x = other.surf_mana_x
				meu_y = other.surf_mana_y
			}
		}
		
		// reseta surface
		surface_reset_target()		
		// desenhando surtface
		draw_surface(surf_mana, surf_mana_x, surf_mana_y)
		
		surface_resize(surf_mana, surf_mana_w, surf_mana_h)
	} else {
		//crio ela
		surf_mana = surface_create(surf_mana_w, surf_mana_h)
	}
}

// Criando surface para os produtos
desenha_produtos = function(){
	//Criando surface para desenhar os produtos
	// cheacando se surface existe
	if (surface_exists(surf_prod)) {
		// configura surface
		surface_set_target(surf_prod)
		draw_clear_alpha(c_black, 0)
		
		//draw_rectangle_color(0, 0, surf_prod_w, surf_prod_h, c_black, c_black, c_black, c_black, false)
		
		// configurando o alpha
		gpu_set_colorwriteenable(1, 1, 1, 0)
		
		
		// desenhando produto
		with(obj_produto){
			desenha_produto()
			meu_x = other.surf_prod_x
			meu_y = other.surf_prod_y
		}
		
		// reseta alpha
		gpu_set_colorwriteenable(1, 1, 1, 1)
		
		// reseta surface
		surface_reset_target()
		
		// desenhando surtface
		draw_surface(surf_prod, surf_prod_x, surf_prod_y)
	} else {
		//crio ela
		surf_prod = surface_create(surf_prod_w, surf_prod_h)
	}
}


// Cria a quantidade de produtos na struct
cria_produtos(array_length(global.struct_produtos))
cria_managers()