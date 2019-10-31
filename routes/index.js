var express = require('express');
var router = express.Router();
var sha1 = require('js-sha1');

/* GET home page. */
router.get('/', function(req, res, next) {
    let sess = req.session;
    var connection = req.connection;
    connection.query("SELECT * FROM type", function(err, listeTypes, f) {
        connection.query("SELECT * FROM secteursactivite WHERE image IS NOT NULL LIMIT 8", function(error, listeActivites, fie) {
            connection.query("SELECT *,secteursactivite.nom AS nomActivite FROM offres,secteursactivite WHERE secteurActivite_idsecteurActivite=idsecteurActivite ORDER BY dateCreation DESC LIMIT 5", function(err, result, field) {
                return res.render('index', { title: 'Accueil', listeTypes: listeTypes, listeActivites: listeActivites, listeOffres: result, css: "index.css", session: req.session });
            });
        });
    });
});

router.post('/login', function(req, res, next) {
    var connection = req.connection;
    var identifiant = escape(req.body.identifiant);
    var password = sha1(req.body.password);
    if (identifiant == 'admin') {
        connection.query('SELECT * FROM admin WHERE motDePasse=?', [password], function(error, results, fields) {
            if (results.length == 0) {
                //res.render('error', { title: "Erreur", message: "mot de passe incorrect", css: "index.css", session: req.session, error: error });
                req.session.error = 'mot de passe incorrect';
                res.redirect('back');
            } else {
                req.session.type = 'admin';
                req.session.nom = 'admin';
                res.redirect('/admin');
                //res.render('admin', { title: 'Administrateur', css: 'index.css', session: req.session });
            }
        });
    } else {
        connection.query('SELECT * FROM entreprises WHERE siret=? AND motDePasse=? AND actif=1', [identifiant, password], function(error, results, fields) {
            if (results.length != 0) {
                req.session.type = 'entreprise';
                req.session.idEntreprise = results[0].idEntreprise;
                req.session.nom = results[0].nomEntreprise;
                res.redirect('/entreprise');
            } else {
                connection.query('SELECT * FROM candidats WHERE email=? AND motDePasse=? AND actif=1', [identifiant, password], function(error, results, fields) {
                    if (results.length != 0) {
                        req.session.type = 'candidat';
                        req.session.nom = results[0].prenom;
                        req.session.idCandidat = results[0].idCandidat;
                        res.redirect('/candidat');
                    } else {
                        req.session.error = 'paramètres de connexion incorrects';
                        res.redirect('back');
                    }
                });
            }
        });
    }
});

router.get('/logout', function(req, res, next) {
    req.session.destroy((err) => {
        if (err) {
            return console.log(err);
        }
        res.redirect('/');
    });
});
router.get('/admin', function(req, res, next) {
    if ((req.session.type === undefined) || req.session.type !== 'admin') {
        res.render('error', { title: "Erreur", message: "Vous ne pouvez pas voir cette page", css: "index.css", session: req.session });
    } else {
        res.render('admin', { title: 'Administrateur', css: 'index.css', session: req.session });
    }
});
module.exports = router;