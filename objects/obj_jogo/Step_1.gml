atualiza_tempo();

// deixando o jogo mais rapido
if (keyboard_check(vk_space)) {
	global.game_spd = 10
} else {
	global.game_spd = 1
}

if (keyboard_check_pressed(ord("L"))) {
	global.gold += 1000
}

gerencia_produtos()
gerencia_managers()