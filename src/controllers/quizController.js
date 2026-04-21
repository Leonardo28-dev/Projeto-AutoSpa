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