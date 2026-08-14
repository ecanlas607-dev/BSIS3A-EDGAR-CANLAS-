# My Project (Node.js + Express)

Simpleng web app na may file upload feature. Ito ang structure:

```
myproject/
├── server.js       <- main na file, dito tumatakbo ang server
├── package.json
├── views/
│   └── index.ejs   <- ang homepage
├── style/
│   └── main.css    <- styling
└── upload/         <- dito napupunta ang mga na-upload na files
```

## Paano patakbuhin (UNANG BESES LANG ITO)

1. I-extract ang zip file kung saan mo gusto (halimbawa Desktop).
2. Buksan ang **Command Prompt** o **PowerShell**, tapos pumunta sa folder:
   ```
   cd Desktop\myproject
   ```
3. I-install ang mga kailangang packages:
   ```
   npm install
   ```
   (Kailangan mo munang naka-install ang Node.js: https://nodejs.org)

## Paano patakbuhin (TUWING GUSTO MO NA LANG RUNNIN)

```
npm start
```

Tapos buksan ang browser mo sa:

```
http://localhost:3000
```

## Optional: Auto-restart habang nag-eedit ka ng code

```
npm run dev
```

Ito ay gumagamit ng `nodemon`, kaya kada i-save mo ang file, automatic na mag-re-restart ang server.
