var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

router.post("/salvar",function(req, res) {
    quizController.salvar(req, res);
});

//  GET trás os dados que o gráfico vai exibir.
// O ":idUsuario" é um parâmetro de rota (req.params).


router.get("/buscar/:idUsuario", function (req, res) {
    quizController.buscar(req, res);
})

module.exports = router;


