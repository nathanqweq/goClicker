comprado = global.managers[indice]
meu_y = 0
meu_x = 0
desenha_manager = function(){
	draw_self()

	// desenhando meu custo
	draw_set_halign(1)
	draw_set_valign(1)
	var _str = convert_num(custo)
	var _txt = comprado == true ? "VENDIDO!!" : _str
	gpu_set_colorwriteenable(1, 1, 1, 0)
	draw_text(x+sprite_width/2, y, _txt)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	draw_set_halign(-1)
	draw_set_valign(-1)
}
