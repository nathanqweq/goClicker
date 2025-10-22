// cria level

level = 0

// mais informações do produto
timer = 0

meu_x = 0
meu_y = 0

// definindo se devo clicar
clicar = false

if (array_length(global.managers) <= indice) {
	tem_manager = global.managers[indice]
} else {
	array_push(global.managers, 0)
	tem_manager = 0
}



// meus custos
custo = custo_base

comprado = false
efeito_comprar = false

lucro = lucro_base

// inserindo na lista de produtos
global.produtos[indice] = id

incremento = 1.07

comprar = function() {
	// tira dinheiro
	global.gold -= custo
	comprado = true
	
	var _custo_atual = floor(custo_base * (power(incremento, level)))
				
	//aumentando custo
	custo += _custo_atual
	// ajustando level
	level ++
	// ajustando lucro
	lucro = lucro_base * level
}

acao = function(){
	timer = 0
	clicar = tem_manager
			
	// dando dinheiro
	global.gold += lucro
}

// Desenhando produto
desenha_produto = function(){
	// Desenhando bloco do produto
	draw_self()
	draw_set_font(fnt_texto)
	// Desenha icone do produto
	draw_sprite(spr_item, indice, x, y - 16)
	
	// variaveis para o level
	draw_set_valign(1)
	draw_set_halign(1)
	var _x = x
	var _y = y+24

	// Desenhando fundo do level
	draw_ellipse_color(_x-24, _y-16, _x+24, _y+16, c_dkgray, c_dkgray, false)
	
	gpu_set_colorwriteenable(1, 1, 1, 0)
	// Desenhando level
	draw_text(_x, _y, level)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	
	//Variaveis para barra de progresso
	var _x1 = x + 42
	var _y1 = y - 32
	var _larg = sprite_width / 1.2
	var _x2 = _x1 + _larg
	var _y2 = _y1 + sprite_height / 4
	// Desenhando as bordas da barra
	draw_rectangle_color(_x1-1, _y1-1, _x2+1, _y2+1, c_black, c_black, c_black, c_black, false)
	// Desenhando fundo da barra
	draw_rectangle_color(_x1, _y1, _x2, _y2, c_gray, c_gray, c_gray, c_gray, false)
	// Progresso da barra
	var _progresso = (timer / tempo) * _larg
	draw_rectangle_color(_x1, _y1, _x1+_progresso, _y2, c_green, c_green, c_green, c_green, false)

	// desenhando o quanto produto rende
	// ajuste de alinhamento
	draw_set_halign(2)
	var _str = convert_num(lucro)
	gpu_set_colorwriteenable(1, 1, 1, 0)
	draw_text(_x2 - 4, _y1+sprite_height / 8, _str)
	// voltando o alinhamento para o centro
	draw_set_halign(1)

	//Desenhando custo
	// desenhando fundo
	_x1 = x + 42
	_y1 = y + 8
	var _larg = sprite_width / 2
	_x2 = _x1 + _larg
	_y2 = _y1 + 32
	// definindo cor na possibilidade de comprar
	var _cor = global.gold >= custo ? c_green : c_grey
	var _str = convert_num(custo)

	// desenha borda caso mouse em cima
	if (efeito_comprar){
		draw_rectangle_color(_x1-1, _y1-1, _x2+1, _y2+1, c_yellow, c_yellow, c_yellow, c_yellow, false)
	}
	draw_rectangle_color(_x1, _y1, _x2, _y2, _cor, _cor, _cor, _cor, false)
	draw_text_transformed(_x1 + _larg/2, _y1 + 16, _str, 1, 1, 0)


	// desenhando o tempo de execução
	// descobrindo quantos segundos
	var _s = floor((tempo - timer) % 60)
	var _m = ((tempo - timer) div 60) % 60
	var _h = ((tempo - timer) div 60) div 60

	draw_set_halign(2)
	// definindo a exibição de tempo
	var _seg = _s > 9 ? _s : "0" + string(_s)
	var _min = _m > 9 ? _m : "0" + string(_m)
	var _hor = _h > 9 ? _h : "0" + string(_h)
	draw_text(x+sprite_width-24, _y1+16, string("{0}:{1}:{2}",_hor, _min, _seg))
	gpu_set_colorwriteenable(1, 1, 1, 1)
	draw_set_halign(1)
	draw_set_valign(-1)
	draw_set_halign(-1)
	
	if (efeito_comprar){
		exibe_info()
	}
	
	draw_set_font(-1)
}

// Exibindo informações do produto
exibe_info = function() {
	var _x1 = x + sprite_width + 12
	var _y1 = y - sprite_height/2
	var _marg = 5
	
	// Desenhando borda
	draw_sprite_stretched(spr_info, 0, _x1, _y1, sprite_width, sprite_height)
	
	gpu_set_colorwriteenable(1, 1, 1, 0)
	draw_text(_x1 + _marg, _y1 + _marg, nome)
	
	// Descrição
	draw_text_ext(_x1 + _marg, _y1 + 30, descricao, 20, sprite_width - _marg * 2)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	
}