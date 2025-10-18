// Desenhando bloco
draw_self()

// Desenhando produto na esquerda
draw_sprite(spr_item, 0, x, y - 16)

// alinha texto
draw_set_valign(1)
draw_set_halign(1)

// cenmtro do level
var _x = x
var _y = y+24

// desenhando elipse atras do level
draw_ellipse_color(_x-24, _y-16, _x+24, _y+16, c_dkgray, c_dkgray, false)
// desenhando level
draw_text(_x, _y, level)

// desenhando barra de progresso
var _x1 = x + 42
var _y1 = y - 32
var _larg = sprite_width / 1.5
var _x2 = _x1 + _larg
var _y2 = _y1 + sprite_height / 4
// desenhando as bordas da barra
draw_rectangle_color(_x1-1, _y1-1, _x2+1, _y2+1, c_black, c_black, c_black, c_black, false)
// desenhando fundo da barra
draw_rectangle_color(_x1, _y1, _x2, _y2, c_gray, c_gray, c_gray, c_gray, false)
// desenhando o progresso da barra
var _progresso = (timer / tempo) * _larg
draw_rectangle_color(_x1, _y1, _x1+_progresso, _y2, c_green, c_green, c_green, c_green, false)

//Desenhando custo
// desenhando fundo
_x1 = x + 42
_y1 = y + 8
_x2 = _x1 + 64
_y2 = _y1 + 32
var _cor = c_green
var _str = string_format(custo, 0, 0)

// desenha borda caso mouse em cima
if (efeito_comprar){
	draw_rectangle_color(_x1-1, _y1-1, _x2+1, _y2+1, _cor, _cor, _cor, _cor, false)
}
draw_rectangle_color(_x1, _y1, _x2, _y2, _cor, _cor, _cor, _cor, false)
draw_text_transformed(_x1 + 32, _y1 + 16, "R$ " + _str, 1, 1, 0)



// resetando alinhamento do texto
draw_set_valign(-1)
draw_set_halign(-1)