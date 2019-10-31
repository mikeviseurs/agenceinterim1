var express = require('express');
var router = express.Router();
var sha1 = require('js-sha1');
var escape = require('escape-html');
router.get('/', function(req, res, next) {
    var connection = req.connection;
    var query = connection.query('SELECT *,secteursactivite.nom AS nomActivite FROM offres,secteursactivite WHERE secteurActivite_idsecteurActivite=idsecteurActivite ORDER BY dateCreation DESC', function(err, rows, fields) {
        if (err) throw err;
        // console.log('The solution is: ', rows);
        res.render('rechercheOffres', { title: 'liste des offres', listeOffres: rows, css: "index.css", session: req.session });
    });
});

/* GET new offre page. */
router.get('/new', function(req, res, next) {
    if (req.session.type !== 'entreprise') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    connection.query("SELECT * FROM experiences", function(err, result, field) {
        connection.query("SELECT * FROM secteursactivite", function(err2, result2, field2) {
            connection.query("SELECT * FROM niveauetudes", function(err3, result3, field3) {
                res.render('ajoutOffre', { title: 'Accueil', "experiences": result, "activites": result2, "etudes": result3, css: "index.css", session: req.session });
            });
        });
    });
});

/* GET new offre page. */
router.post('/new', function(req, res, next) {
    if (req.session.type !== 'entreprise') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    var values = {
        Entreprise_idEntreprise: req.session.idEntreprise,
        titreOffre: escape(req.body.titreOffre),
        description: escape(req.body.description),
        dateDebut: escape(req.body.dateDebut),
        dateFin: escape(req.body.dateFin),
        dateCreation: new Date(),
        secteurActivite_idsecteurActivite: req.body.activite,
        experience_idexperience: req.body.exp,
        niveauEtudes_idniveauEtudes: req.body.etude,
        description: req.body.message
    };
    connection.query('INSERT INTO offres SET ?', values, function(error, results, fields) {
        if (error) throw error;
        // Neat!
        connection.query('SELECT * FROM offre  ORDER BY dateCreation DESC', function(error2, results2, field2) {
            res.render('rechercheOffres', { title: 'Liste des Offres', listeOffres: results2, css: "index.css", session: req.session });
        });
    });
});

//delete offre page
router.get('/delete/:id', function(req, res, next) {
    var id = req.params.id;
    res.render('supprimerOffre', { title: 'supprimer une offre', id: id, css: "index.css", session: req.session });
});


router.get('/detail/:id', function(req, res, next) {
    var id = req.params.id;
    var connection = req.connection;
    connection.query('SELECT titreOffre,description,dateDebut,dateFin,dateCreation,secteursactivite.nom AS nomActivite,experiences.interval AS intervalExperience,niveauetudes.intitule AS intituleNiveauEtudes FROM offres,secteursactivite,experiences,niveauetudes WHERE secteurActivite_idsecteurActivite=idsecteurActivite AND experience_idexperience=idexperience AND niveauEtudes_idniveauEtudes=idniveauEtudes AND idOffre=' + id, function(error, results, fields) {
        res.render('detailOffre', { title: "detail de l'offre", offre: results[0], css: "index.css", session: req.session });
    });
});
module.exports = router;