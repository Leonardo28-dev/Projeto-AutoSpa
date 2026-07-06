var database = require("../database/config");

function salvar(acertos, erros, fk_usuario) {
    var instrucaoSql = `
        INSERT INTO Resultado_quiz (acertos, erros, fk_usuario) 
        VALUES (${acertos}, ${erros}, ${fk_usuario});
    `;

    console.log("Executando a instrução SQL:\n " + instrucaoSql);
    return database.executar(instrucaoSql);
}


    /*  'ORDER BY'
       O banco de dados neste caso armazena várias tentativas do usuário. 
       Para o gráfico da Dashboard, pego somente o mais recente
        ORDER BY idResultado DESC: Organizo do maior ID (último inserido) para o menor.
        LIMIT 1: O banco me retorna apenas 1 linha(a minha última tentativa).
    

    console.log("Executando a instrução SQL:\n " + instrucaoSql);
    return database.executar(instrucaoSql);

*/
function buscar(idUsuario) {

    var instrucaoSql =
     `SELECT 
     acertos, erros
     FROM Resultado_quiz WHERE fk_usuario = ${idUsuario} 
     ORDER BY idquiz DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    salvar,
    buscar
};