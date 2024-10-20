
new sampcode_page = 0;
#define MAX_ITEM_PAG 15

#include <YSI_Coding\y_hooks>


new locgps[19][2][100] = {
    {"Hospital", "Los Santos"},
    {"Aeroporto", "Las Venturas"},
    {"Escola", "Los Santos"},
    {"Posto", "Las Venturas"},
    {"Shopping", "San Fierro"},
    {"Estadio", "Las Venturas"},
    {"Praia", "Los Santos"},
    {"Montanha", "San Fierro"},
    {"Fábrica", "Los Santos"},
    {"Banco", "Los Santos"},
    {"Mercado", "Las Venturas"},
    {"Café", "San Fierro"},
    {"Restaurante", "Las Venturas"},
    {"Hotel", "Los Santos"},
    {"Centro Comercial", "San Fierro"},
    {"Parque", "Los Santos"},
    {"Museu", "San Fierro"},
    {"Biblioteca", "Los Santos"},
    {"Farmácia", "Las Venturas"}
};

stock CriarPaginacao(playerid, const titulo[], itens[][][], totalitem) {

    new inicio = sampcode_page * MAX_ITEM_PAG;
    new idx = inicio + MAX_ITEM_PAG;
    if (idx > totalitem) idx = totalitem;

    new list[1024];
    list[0] = 0; // EOS

    for (new i = inicio; i < idx; i++) {
        new linha[256];
        format(linha, sizeof(linha), "%s  {9a9a9a}%s", itens[i][0], itens[i][1]);
        strcat(list, linha);
        strcat(list, "\n");
    }
    if (sampcode_page > 0) 
        strcat(list, "\n[<<] Voltar Página");
    
    if (idx < totalitem) 
        strcat(list, "\n[>>] Próxima Página");
    
    Dialog_Show(playerid, D_FUNCAO_PAG, DIALOG_STYLE_LIST, titulo, list, "Selecionar", "Cancelar");
}

Dialog:D_FUNCAO_PAG(playerid, response, listitem, inputtext[]) {
    if (!response) return true;

    new index = sampcode_page * MAX_ITEM_PAG + listitem;

    if (listitem < MAX_ITEM_PAG) {
        if (index < 19) { 
            SendClientMessage(playerid, -1, va_return("Você selecionou: %s, %s", locgps[index][0], locgps[index][1])); // se ele seleciona um item 
            new titt[32] = "Locais";
            CriarPaginacao(playerid, titt, locgps, 19);
        }
    } 
    if (listitem < sampcode_page * MAX_ITEM_PAG) {
        if (sampcode_page > 0) {
            sampcode_page--;
            new titulo[32] = "Locais"; 
            CriarPaginacao(playerid, titulo, locgps, 19);      // proxima pagina
        }
    } 
    else if (listitem >= (sampcode_page + 1) * MAX_ITEM_PAG) {
        sampcode_page++;
        new title[32] = "Locais"; 
        CriarPaginacao(playerid, title, locgps, 19);          //volta uma pagina
    
    }
    return 1;
}

CMD:zx(playerid) {
    new title[32] = "Locais"; 
    CriarPaginacao(playerid, title, locgps, 19); 
    return 1;
}
