Translations = {
    ["en"] = {
        ["error_retrieving_data"] = "Error: Unable to retrieve data.",
        ["not_unconscious"] = "You are not unconscious!",
        ["doctor_on_duty"] = "A doctor is on duty. Use them instead.",
        ["not_enough_money"] = "You don't have enough money! You need $",
        ["npc_doctor_on_way"] = "An NPC doctor is on the way!",
        ["revived_by_npc"] = "You were revived by an NPC doctor, for $",
        ["cooldown"] = "You should be patient, a doctor is already on the way.",
    },
    ["es"] = {
        ["error_retrieving_data"] = "Error: No se pudo recuperar la información.",
        ["not_unconscious"] = "¡No estás inconsciente!",
        ["doctor_on_duty"] = "Un médico está de guardia. Acude a él.",
        ["not_enough_money"] = "¡No tienes suficiente dinero! Necesitas $",
        ["npc_doctor_on_way"] = "¡Un médico NPC está en camino!",
        ["revived_by_npc"] = "Un médico NPC te ha reanimado, por $",
        ["cooldown"] = "Ten paciencia, un médico ya está en camino.",
    },
    ["fr"] = {
        ["error_retrieving_data"] = "Erreur : Impossible de récupérer les informations.",
        ["not_unconscious"] = "Vous n'êtes pas inconscient !",
        ["doctor_on_duty"] = "Un médecin est en service. Consultez-le.",
        ["not_enough_money"] = "Vous n'avez pas assez d'argent ! Il vous faut $",
        ["npc_doctor_on_way"] = "Un médecin NPC est en route !",
        ["revived_by_npc"] = "Un médecin NPC vous a réanimé, pour $",
        ["cooldown"] = "Soyez patient, un médecin est déjà en chemin.",
    },
    ["de"] = {
        ["error_retrieving_data"] = "Fehler: Daten konnten nicht abgerufen werden.",
        ["not_unconscious"] = "Du bist nicht bewusstlos!",
        ["doctor_on_duty"] = "Ein Arzt ist im Dienst. Geh zu ihm.",
        ["not_enough_money"] = "Du hast nicht genug Geld! Du brauchst $",
        ["npc_doctor_on_way"] = "Ein NPC-Arzt ist unterwegs!",
        ["revived_by_npc"] = "Ein NPC-Arzt hat dich wiederbelebt, für $",
        ["cooldown"] = "Hab Geduld, ein Arzt ist bereits unterwegs.",
    },
    ["it"] = {
        ["error_retrieving_data"] = "Errore: Impossibile recuperare i dati.",
        ["not_unconscious"] = "Non sei incosciente!",
        ["doctor_on_duty"] = "C'è un medico in servizio. Rivolgiti a lui.",
        ["not_enough_money"] = "Non hai abbastanza soldi! Ti servono $",
        ["npc_doctor_on_way"] = "Un medico NPC sta arrivando!",
        ["revived_by_npc"] = "Un medico NPC ti ha rianimato, per $",
        ["cooldown"] = "Abbi pazienza, un medico è già in arrivo.",
    },
    ["pt"] = {
        ["error_retrieving_data"] = "Erro: Não foi possível recuperar os dados.",
        ["not_unconscious"] = "Você não está inconsciente!",
        ["doctor_on_duty"] = "Há um médico de plantão. Procure-o.",
        ["not_enough_money"] = "Você não tem dinheiro suficiente! Precisa de $",
        ["npc_doctor_on_way"] = "Um médico NPC está a caminho!",
        ["revived_by_npc"] = "Um médico NPC reviveu você, por $",
        ["cooldown"] = "Aguarde, um médico já está a caminho.",
    },
    ["ru"] = {
        ["error_retrieving_data"] = "Ошибка: не удалось получить данные.",
        ["not_unconscious"] = "Вы не без сознания!",
        ["doctor_on_duty"] = "Дежурный врач уже работает. Обратитесь к нему.",
        ["not_enough_money"] = "У вас недостаточно денег! Нужно $",
        ["npc_doctor_on_way"] = "NPC-врач уже в пути!",
        ["revived_by_npc"] = "NPC-врач привел вас в сознание, за $",
        ["cooldown"] = "Будьте терпеливы, врач уже в пути.",
    },
    ["nl"] = {
        ["error_retrieving_data"] = "Fout: Kan gegevens niet ophalen.",
        ["not_unconscious"] = "Je bent niet bewusteloos!",
        ["doctor_on_duty"] = "Er is een dokter beschikbaar. Ga naar hem toe.",
        ["not_enough_money"] = "Je hebt niet genoeg geld! Je hebt $ nodig",
        ["npc_doctor_on_way"] = "Een NPC-dokter is onderweg!",
        ["revived_by_npc"] = "Je bent gereanimeerd door een NPC-dokter, voor $",
        ["cooldown"] = "Heb geduld, een dokter is al onderweg.",
    }
}


function _U(str)
    local lang = Config.Language
    return Translations[lang] and Translations[lang][str] or Translations["en"][str]
end
