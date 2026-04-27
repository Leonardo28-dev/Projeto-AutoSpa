var database = require("../database/config");

function salvar(acertos, erros, fk_usuario) {
    var instrucaoSql = `
        INSERT INTO Resultado_quiz (acertos, erros, fk_usuario) 
        VALUES (${acertos}, ${erros}, ${fk_usuario});
    `;

    console.log("Executando a instrução SQL:\n " + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    salvar
};

/*
// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha,cpf) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha,cpf);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha,cpf) VALUES ('${nome}', '${email}', '${senha}','${cpf}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};
*/