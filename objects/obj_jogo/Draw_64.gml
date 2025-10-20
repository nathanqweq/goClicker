// desenha dinheiro

var _n = 1
var _alt = 20
draw_set_halign(0)
var _str = "R$ " + string_format(global.gold, 0, 2)
draw_text(20, _alt * _n++, _str)
draw_set_halign(-1)


// quero saber quanto dinheiro por segundo
var _dinheiro_seg = 0

for (var i=0; i< array_length(global.produtos); i++){
	if (global.produtos[i] != 0) {
		var _atual = global.produtos[i]
		with(_atual){
			if (tem_manager && comprado){
			_dinheiro_seg += (lucro / tempo)
			}
		}
	}
}

draw_text(20, _alt * _n++, _dinheiro_seg)