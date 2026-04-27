var quizModel = require("../models/quizModel");

function salvar(req, res) {
  var acertos = req.body.acertosServer;
var erros = req.body.errosServer;
var fk_usuario = req.body.fk_usuarioServer;

    if (acertos == undefined || erros == undefined || fk_usuario == undefined) {
        res.status(400).send("Dados do quiz estão undefined!");
    } else {
        quizModel.salvar(acertos, erros, fk_usuario)
            .then(function (resultado) {
                res.json(resultado);
            }).catch(function (erro) {
                console.log(erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    salvar
};


/*
function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var cpf = req.body.cpfServer;


    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (cpf == undefined) {
        res.status(400).send("Seu cpf está undefined!");


    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, cpf)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}
    */