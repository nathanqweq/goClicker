// cria level

level = 0

// mais informações do produto
timer = 0

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


// Desenhando produto
desenha_produto = function(){
	// Desenhando bloco do produto
	draw_self()
	draw_sprite(spr_item, 0, x, y - 16)
	
	// variaveis para o level
	draw_set_valign(1)
	draw_set_halign(1)
	var _x = x
	var _y = y+24

	// Desenhando fundo do level
	draw_ellipse_color(_x-24, _y-16, _x+24, _y+16, c_dkgray, c_dkgray, false)
	// Desenhando level
	draw_text(_x, _y, level)
	
	//Variaveis para barra de progresso
	var _x1 = x + 42
	var _y1 = y - 32
	var _larg = sprite_width / 1.5
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
	var _str = "R$ " + string_format(lucro, 0, 2)
	draw_text(_x2, _y1+sprite_height / 8, _str)
	// voltando o alinhamento para o centro
	draw_set_halign(1)

	//Desenhando custo
	// desenhando fundo
	_x1 = x + 42
	_y1 = y + 8
	_x2 = _x1 + 64
	_y2 = _y1 + 32
	// definindo cor na possibilidade de comprar
	var _cor = global.gold >= custo ? c_green : c_grey
	var _str = string_format(custo, 0, 0)

	// desenha borda caso mouse em cima
	if (efeito_comprar){
		draw_rectangle_color(_x1-1, _y1-1, _x2+1, _y2+1, c_yellow, c_yellow, c_yellow, c_yellow, false)
	}
	draw_rectangle_color(_x1, _y1, _x2, _y2, _cor, _cor, _cor, _cor, false)
	draw_text_transformed(_x1 + 32, _y1 + 16, "R$ " + _str, 1, 1, 0)

	// desenhando o tempo de execução
	// descobrindo quantos segundos
	var _s = floor((tempo - timer) % 60)
	var _m = (tempo - timer) div 60
	var _h = ((tempo - timer) div 60) div 60

	draw_set_halign(2)
	// definindo a exibição de tempo
	var _seg = _s > 9 ? _s : "0" + string(_s)
	var _min = _m > 9 ? _m : "0" + string(_m)
	var _hor = _h > 9 ? _h : "0" + string(_h)
	draw_text(x+sprite_width-8, _y1+16, string("{0}:{1}:{2}",_hor, _min, _seg))
	draw_set_halign(1)

	// resetando alinhamento do texto
	draw_set_valign(-1)
	draw_set_halign(-1)
}