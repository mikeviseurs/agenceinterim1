var express = require('express');
var router = express.Router();
var sha1 = require('js-sha1');
var escape = require('escape-html');
router.get('/', function(req, res, next) {
    if (req.session.type !== 'entreprise') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    } else {
        res.render('entreprise', { title: 'Entreprise', erreur: '', css: "index.css", session: req.session });
    }
});

/* GET new entreprise page. */
router.get('/new', function(req, res, next) {
    res.render('ajoutEntreprise', { title: 'Nouvelle Entreprise', erreur: '', css: "inscription.css", session: req.session });
});

/* GET new entreprise page. */
router.post('/new', function(req, res, next) {
    var connection = req.connection;
    var values = {
        nomEntreprise: escape(req.body.nomEntreprise),
        siret: escape(req.body.siret),
        codeAPE: escape(req.body.codeAPE),
        interlocuteur: escape(req.body.interlocuteur),
        internet: escape(req.body.internet),
        motDePasse: sha1(req.body.motDePasse),
        adresse: escape(req.body.adresse),
        codePostal: escape(req.body.codePostal),
        ville: escape(req.body.ville),
        email: escape(req.body.email),
        tel: escape(req.body.tel),
        dateInscription: new Date()
    };
    connection.query('SELECT email FROM entreprises WHERE email=?', [values.email], function(err, liste, fie) {
        if (liste.length == 0) {
            var query = connection.query('INSERT INTO entreprises SET ?', values, function(error, results, fields) {
                if (error) throw error;
                // Neat!
            });
            res.redirect('/');
        } else {
            res.render('ajoutEntreprise', { title: 'Nouvelle Entreprise', erreur: 'email déjà utilisé', css: "inscription.css", session: req.session });
        }
    });
});
router.get('/offre', function(req, res, next) {
    if (req.session.type !== 'entreprise') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    connection.query('SELECT *,secteursactivite.nom AS nomActivite FROM offres,secteursactivite WHERE Entreprise_idEntreprise=? AND secteurActivite_idsecteurActivite=idsecteurActivite  ORDER BY dateCreation DESC', [req.session.idEntreprise], function(err, results, fields) {
        res.render('rechercheOffres', { title: 'Vos Offres', listeOffres: results, css: "index.css", session: req.session });
    });
});

/* GET delete entreprise */
router.get('/delete', function(req, res, next) {
    if (req.session.type !== 'entreprise') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    }
    var connection = req.connection;
    connection.query("UPDATE entreprises SET actif=0 WHERE idEntreprise=?", [req.session.idEntreprise], function(err, results, fields) {
        res.redirect('/logout');
    });
});

module.exports = router;