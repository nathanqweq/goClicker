if (comprado) {
	if (clicar){
		// aumenta o timer
		timer += global.framerate
	
		if (timer > tempo) {
			timer = 0
			clicar = tem_manager
			// retorna dinheiro
			global.gold += lucro
			
			// aumentando custo
			custo *= 2
			// ajusta o lucro
			level++
			//lucro com base no nivel
			lucro = lucro_base  * level
		}
	}
}



// checando clique
var _mouse_sobre = position_meeting(mouse_x, mouse_y, id)
var _mouse_click = mouse_check_button_pressed(mb_left)

if (_mouse_sobre) {
	if (_mouse_click) {
		clicar = true
	}
	
	// checando se mouse está na caixa de compra
	var _x1 = x + 42
	var _y1 = y + 8
	var _x2 = _x1 + 64
	var _y2 = _y1 + 32
	
	var _mouse_caixa = point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2)
	efeito_comprar = _mouse_caixa
	if (_mouse_caixa){		
		// checa clique
		if (_mouse_click){
			// checa se tem dinheiro
			if (global.gold >= custo){
				// tira dinheiro
				global.gold -= custo
				comprado = true
			}
		}
	}
}

var _x1 = x + 42
var _y1 = y + 8
var _x2 = _x1 + 64
var _y2 = _y1 + 32

var _mouse_caixa = point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2)
efeito_comprar = _mouse_caixa