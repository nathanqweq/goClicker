var _mouse_sobre = position_meeting(mouse_x, mouse_y, id)
var _mouse_click = mouse_check_button_pressed(mb_left)

if (_mouse_sobre && comprado == false){
	if (_mouse_click){
		// checagem se pode comprar
		if (global.gold >= custo) {
			global.gold -= custo
			// avisando que foi vendido
			global.managers[indice] = true
			comprado = true
			
			// avisando ao produto que deve fazer automatico
			global.produtos[indice].fazer = true
			global.produtos[indice].tem_manager = true
		}
	}
}
