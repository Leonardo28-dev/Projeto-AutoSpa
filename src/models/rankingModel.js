var database = require("../database/config");

function listarRanking() {
    var instrucaoSql =
        `SELECT 
     usuario.nome, 
     MAX(Resultado_quiz.acertos) AS acertos
     FROM usuario 
     JOIN Resultado_quiz
     ON usuario.id=Resultado_quiz.fk_usuario
    GROUP BY usuario.nome, usuario.id
    ORDER BY acertos DESC
    LIMIT 3
     `
// neste caso peguei  o MAIOR número de acertos de cada usuário.
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}
module.exports = {
    listarRanking
}