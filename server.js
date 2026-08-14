const express = require('express');
const path = require('path');
const multer = require('multer');
const fs = require('fs');

const app = express();
const PORT = 3000;

// ---- View engine (para sa dynamic HTML sa views/ folder) ----
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// ---- Static folders (CSS at uploaded files) ----
app.use('/style', express.static(path.join(__dirname, 'style')));
app.use('/upload', express.static(path.join(__dirname, 'upload')));
app.use(express.urlencoded({ extended: true }));

// ---- Setup ng file upload (multer) ----
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, 'upload'));
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + '-' + file.originalname;
    cb(null, uniqueName);
  }
});
const upload = multer({ storage });

// ---- ROUTES ----

// Home page - nagpapakita ng listahan ng mga na-upload na files
app.get('/', (req, res) => {
  const uploadDir = path.join(__dirname, 'upload');
  fs.readdir(uploadDir, (err, files) => {
    if (err) files = [];
    res.render('index', { files });
  });
});

// Upload endpoint
app.post('/upload', upload.single('myfile'), (req, res) => {
  res.redirect('/');
});

// ---- Start server ----
app.listen(PORT, () => {
  console.log(`Server running sa http://localhost:${PORT}`);
});
