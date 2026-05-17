var rankingModel = require("../models/rankingModel")

function listarRanking(req, res) {
    rankingModel.listarRanking()
        .then(function (resultado) {

            res.status(200).json(resultado);

        }).catch(function (erro) {

            console.log(erro);

            console.log("Houve um erro para buscar os nomes do ranking.", erro.sqlMessage);
            
            res.status(500).json(erro.sqlMessage);
        });

}

module.exports = {
    listarRanking
}



