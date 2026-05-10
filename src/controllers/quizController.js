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

function buscar(req, res) {

    var idUsuario = req.params.idUsuario;

    if (idUsuario == undefined) {
        res.status(400).send("ID do usuário está undefined!");
    }
    else {
        quizModel.buscar(idUsuario).then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os dados do quiz.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }
}


module.exports = {
    salvar,
    buscar
};

