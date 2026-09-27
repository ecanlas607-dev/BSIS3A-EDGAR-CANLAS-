const express = require('express');
const path = require('path');
const multer = require('multer');
const fs = require('fs');
const session = require('express-session');
const bcrypt = require('bcrypt');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const PORT = 3000;

// ---- Database connection ----
const db = new sqlite3.Database(path.join(__dirname, 'data.sqlite'), (err) => {
  if (err) console.error('DB connection error:', err.message);
  else console.log('Connected to SQLite database.');
});

// ---- View engine ----
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// ---- Static folders ----
app.use('/style', express.static(path.join(__dirname, 'style')));
app.use('/upload', express.static(path.join(__dirname, 'upload')));
app.use(express.urlencoded({ extended: true }));

// ---- Sessions (para maalala na naka-login ang user) ----
app.use(session({
  secret: 'change-this-to-a-random-secret-string',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 1000 * 60 * 60 * 2 } // 2 hours
}));

// ---- Middleware: protect routes na kailangan ng login ----
function requireLogin(req, res, next) {
  if (!req.session.userId) {
    return res.redirect('/login');
  }
  next();
}

// ---- Multer setup (file upload) ----
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, path.join(__dirname, 'upload')),
  filename: (req, file, cb) => cb(null, Date.now() + '-' + file.originalname)
});
const upload = multer({ storage });

// ============================================
// AUTH ROUTES
// ============================================

// ---- GET /login ----
app.get('/login', (req, res) => {
  res.render('login', { error: null });
});

// ---- POST /login ----
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  db.get('SELECT * FROM Users WHERE Username = ?', [username], (err, user) => {
    if (err) {
      console.error(err);
      return res.render('login', { error: 'May problema sa server.' });
    }
    if (!user) {
      return res.render('login', { error: 'Mali ang username o password.' });
    }

    bcrypt.compare(password, user.Password, (err, match) => {
      if (err || !match) {
        return res.render('login', { error: 'Mali ang username o password.' });
      }
      // Success — save sa session
      req.session.userId = user.UserID;
      req.session.username = user.Username;
      req.session.role = user.Role;
      res.redirect('/');
    });
  });
});

// ---- GET /register ----
app.get('/register', (req, res) => {
  res.render('register', { error: null });
});

// ---- POST /register ----
app.post('/register', (req, res) => {
  const { username, password, confirmPassword } = req.body;

  if (password !== confirmPassword) {
    return res.render('register', { error: 'Hindi magkatugma ang password.' });
  }

  db.get('SELECT * FROM Users WHERE Username = ?', [username], (err, existing) => {
    if (existing) {
      return res.render('register', { error: 'Kuha na ang username na iyan.' });
    }

    bcrypt.hash(password, 10, (err, hashedPassword) => {
      if (err) {
        return res.render('register', { error: 'May problema sa server.' });
      }
      db.run(
        'INSERT INTO Users (Username, Password, Role) VALUES (?, ?, ?)',
        [username, hashedPassword, 'staff'],
        (err) => {
          if (err) {
            return res.render('register', { error: 'Hindi na-register. Subukan ulit.' });
          }
          res.redirect('/login');
        }
      );
    });
  });
});

// ---- Logout ----
app.get('/logout', (req, res) => {
  req.session.destroy(() => res.redirect('/login'));
});

// ============================================
// MAIN ROUTES (protected)
// ============================================

app.get('/', requireLogin, (req, res) => {
  const uploadDir = path.join(__dirname, 'upload');
  fs.readdir(uploadDir, (err, files) => {
    if (err) files = [];
    res.render('index', { files, username: req.session.username });
  });
});

app.post('/upload', requireLogin, upload.single('myfile'), (req, res) => {
  res.redirect('/');
});

// ---- Start server ----
app.listen(PORT, () => {
  console.log(`Server running sa http://localhost:${PORT}`);
});
