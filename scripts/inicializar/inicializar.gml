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

global.exibe_managers = false

// Variaveis de dinheiro
global.gold = 1

// informação dos managers
global.managers = [0, 0, 0, 0, 0, 0, 0, 0]

// listas de produtos
global.produtos = []

// Abrindo JSON de produtos
var _file = file_text_open_read("dados.json")
var _txt = "";
// Iterando pelo arquivo de texto até ultiuma linha
while(true) {
	if (file_text_eof(_file)) {
		break
	} else {
		var _linha = file_text_readln(_file)
		_txt += _linha
	}
}
// Converte texto para json
global.struct_produtos = json_parse(_txt).items