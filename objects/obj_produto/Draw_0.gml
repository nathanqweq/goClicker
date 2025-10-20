// So mostra se tiver dinheiro para comprar
if (global.gold > custo/2 or comprado) {
	desenha_produto()
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_gray, .6)
}