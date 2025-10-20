// Configurando o tempo do jogo

// Definido os frames por segundo
#macro FRAMES 60
game_set_speed(FRAMES, gamespeed_fps)

// Usando o deltatime para ajustar o tempo do jogo
// Velocidade do jogo
global.game_spd = 1
// Definindo o framerate do jogo
global.framerate = global.game_spd / FRAMES
// Identificando duração de um segundo
global.gamesegundos = 0

// função para atualizar o tempo do jogo
function atualiza_tempo() {
	//pegando tempo em segundos
	global.gamesegundos = delta_time / 1000000;
	global.framerate = global.gamesegundos * global.game_spd
}

// Variaveis de dinheiro
global.gold = 1

// informação dos managers
global.managers = [0, 0, 0, 0, 0, 0, 0, 0]

// listas de produtos
global.produtos = [0, 0, 0, 0, 0, 0, 0, 0]
