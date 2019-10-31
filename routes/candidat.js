var express = require('express');
var router = express.Router();
var sha1 = require('js-sha1');
var escape = require('escape-html');

/*page de profil du candidat connecté */
router.get('/', function(req, res, next) {
    if (req.session.type !== 'candidat') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    } else {
        var connection = req.connection;
        connection.query('SELECT * FROM candidats WHERE idCandidat=?', [req.session.idCandidat], function(error, results, fields) {
            console.log(results);
            res.render('candidat', { title: 'Candidat', erreur: '', infoCandidat: results[0], css: "profil.css", session: req.session });
        });
    }
});

/* GET new candidat page. */
router.get('/new', function(req, res, next) {
    res.render('ajoutCandidat', { title: 'Nouveau Candidat', erreur: '', css: "inscription.css", session: req.session });
});

/* POST new candidat page. */
router.post('/new', function(req, res, next) {
    var connection = req.connection;
    var values = {
        nom: escape(req.body.nom),
        prenom: escape(req.body.prenom),
        motDePasse: sha1(req.body.motDePasse),
        adresse: escape(req.body.adresse),
        codePostal: escape(req.body.codePostal),
        ville: escape(req.body.ville),
        email: escape(req.body.email),
        tel: escape(req.body.tel),
        dateNaissance: escape(req.body.dateNaissance),
        dateInscription: new Date()
    };
    /* on vérifie si l'utilisateur est déjà inscrit */
    connection.query('SELECT email FROM candidats WHERE email=? AND actif=1', [values.email], function(err, liste, fie) {
        if (liste.length == 0) {
            var query = connection.query('INSERT INTO candidats SET ?', values, function(error, results, fields) {
                if (error) throw error;
                // Neat!
            });
            res.redirect('/');
        } else {
            res.render('ajoutCandidat', { title: 'Nouveau Candidat', erreur: 'email déjà utilisé', css: "inscription.css", session: req.session });
        }
    });
});

/* GET delete candidat */
router.get('/delete', function(req, res, next) {
    if (req.session.type !== 'candidat') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    connection.query("UPDATE candidats SET actif=0 WHERE idCandidat=?", [req.session.idCandidat], function(err, results, fields) {
        res.redirect('/logout');
    });
});

/* liste des offres compatibles*/
router.get('/offre', function(req, res, next) {
    if (req.session.type !== 'candidat') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    connection.query('SELECT *,secteursactivite.nom AS nomActivite FROM offres,candidats,secteursactivite WHERE idCandidat=? AND offres.secteurActivite_idsecteurActivite=idsecteurActivite AND offres.secteurActivite_idsecteurActivite=candidats.secteurActivite_idsecteurActivite ORDER BY dateCreation DESC', [req.session.idCandidat], function(err, results, fields) {
        res.render('rechercheOffres', { title: 'Vos Offres', listeOffres: results, css: "index.css", session: req.session });
    });
});

module.exports = router;