var createError = require('http-errors');
var express = require('express');

const session = require('express-session');


var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var candidatsRouter = require('./routes/candidat');
var entreprisesRouter = require('./routes/entreprise');
var offresRouter = require('./routes/offre');
var $ = require('jquery');
var app = express();

//SESSION
app.use(session({
    secret: 'ssshhhhh',

    saveUninitialized: false,
    resave: false
}));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'agenceinterim'
});

// Make our db accessible to our router
app.use(function(req, res, next) {
    req.connection = connection;
    next();
});

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/candidat', candidatsRouter);
app.use('/entreprise', entreprisesRouter);
app.use('/offre', offresRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error', { title: "Erreur", message: "erreur", css: "index.css", error: err, session: req.session });
});

module.exports = app;