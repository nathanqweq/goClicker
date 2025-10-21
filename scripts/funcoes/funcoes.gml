function convert_num(_num) {
	var _custo2 = _num
	var _valores = ["", "K", "M", "B", "T", "q", "Q", "s", "S", "O", "N", "D"]
	var _i = 0
	// sempre que valor for maior que mill tiro 3 zeros
	while (_custo2 > 1000){
		// tira 3 zeros
		_custo2 /= 1000
		// sempre que rodar sobe para proxima casa
		_i ++
	}
	
	var _str2 = "R$ " + string_format(_custo2, 0, 2) + _valores[_i]
	
	// Retorna string formatada
	return _str2
}