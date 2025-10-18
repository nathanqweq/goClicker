// --- O Loop Lógico do Jogo (Roda a cada 1 segundo) ---

// 1. ZERA AS TAXAS DE PRODUÇÃO (PPS, RPS, DPS)
global.resources[ "CPU Cycles" ].rate = 0;
global.resources[ "RAM Blocks" ].rate = 0;
global.resources[ "Disk I/O" ].rate = 0;

var total_maintenance_cost = 0; // Custo de manutenção total de RAM/s

// 2. CALCULA A PRODUÇÃO E MANUTENÇÃO POR AUTOMATIZADOR (UPGRADE)
var upgrade_array = global.upgrades;

// Loopa por todos os upgrades comprados
for (var i = 0; i < array_length(upgrade_array); i++) {
    var up = upgrade_array[i];

    if (up.bought > 0) {
        // --- Cálculo de Produção ---
        
        // UPGRADE 1: go func() (Produz CPU Cycles)
        if (i == 1) {
            // Fator de eficiência do canal (UPGRADE 2)
            var efficiency_bonus = 1 + (global.upgrades[2].bought * 0.1); 
            
            var production = up.bought * 1.0 * efficiency_bonus;
            
            // Aplica o multiplicador global de prestige
            production *= global.multiplicador_global;
            
            global.resources[ "CPU Cycles" ].rate += production;
        }
        
        // UPGRADE 2: make(chan) (Produz RAM Blocks)
        if (i == 2) {
            var production = up.bought * 1.0; 
            global.resources[ "RAM Blocks" ].rate += production;
        }
        
        // UPGRADE 3: os.File (Produz Disk I/O)
        if (i == 3) {
            var production = up.bought * 1.0; 
            global.resources[ "Disk I/O" ].rate += production;
        }

        // --- Cálculo de Manutenção ---
        
        // Se o upgrade tiver custo de manutenção, adiciona ao custo total
        if (up.maintenance_cost.cost > 0) {
            var cost = up.maintenance_cost.cost * up.bought;
            
            if (up.maintenance_cost.resource == "RAM Blocks") {
                total_maintenance_cost += cost;
            }
            // Adicionar lógica para outros recursos de manutenção aqui, se necessário
        }
    }
}

// 3. APLICA CUSTO DE MANUTENÇÃO (RAM Blocks)
global.resources[ "RAM Blocks" ].rate -= total_maintenance_cost;

// 4. ATUALIZA A CONTAGEM DE RECURSOS E APLICA CAPACIDADE

var resource_keys = variable_struct_get_names(global.resources);

for (var i = 0; i < array_length(resource_keys); i++) {
    var res_name = resource_keys[i];
    var res = global.resources[res_name];

    // Se a taxa de produção for positiva, adiciona o recurso.
    if (res.rate > 0) {
        res.count += res.rate;
    } 
    // Se a taxa for negativa (custo de manutenção maior que produção), consome o recurso.
    else if (res.rate < 0) {
        res.count += res.rate;
    }
    
    // Zera o recurso se a contagem for negativa (dívida)
    if (res.count < 0) {
        res.count = 0;
    }

    // Aplica o limite de capacidade
    if (res.count > res.capacity) {
        res.count = res.capacity;
        // Opcional: Adicionar feedback visual aqui se o recurso atingir o limite
    }
}

// 5. REINICIA O ALARME PARA O PRÓXIMO SEGUNDO
alarm[0] = global.TICK_DURATION; 
