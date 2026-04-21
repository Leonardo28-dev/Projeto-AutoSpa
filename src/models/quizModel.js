var database = require("../database/config");

function salvar(acertos, erros, fk_usuario) {
    var instrucaoSql = `
        INSERT INTO Resultado_quiz (acertos, erros, fk_usuario) 
        VALUES (${acertos}, ${erros}, ${fk_usuario});
    `;

    console.log("Executando SQL: " + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    salvar
};