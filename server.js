const http = require('http');
const fs = require('fs/promises');
const path = require('path');

const PORT = process.env.PORT || 3000;
const PUBLIC_DIR = path.join(__dirname, 'public');

const lore = {
  nodin: {
    name: 'Nodin the Iron Vanguard',
    title: 'Shield of the Ember Frontier',
    origin:
      'Raised in the obsidian valleys, Nodin became a warrior known for standing his ground against impossible odds.',
    mission:
      'Unite the fractured clans and protect the frontier from the Wyrmfall legions.',
    profile: {
      age: 34,
      homeland: 'Ashenreach Valleys',
      faction: 'Ember Frontier Guard',
      motto: 'Hold the line, protect the weak.'
    },
    weapons: [
      {
        name: 'Stormcleaver Blade',
        style: 'Two-handed greatsword',
        detail: 'Forged with stormglass and lightning runes for devastating front-line strikes.'
      },
      {
        name: 'Aegis of Cinders',
        style: 'Tower shield',
        detail: 'A molten-iron shield that absorbs impact and radiates defensive heat.'
      },
      {
        name: 'Runed Spear of Vhal',
        style: 'Ceremonial war spear',
        detail: 'Used to command formations and break cavalry charges with precision.'
      }
    ],
    milestones: [
      'Defended Ember Pass for seven nights during the Frost March',
      'United four rival clans at the Summit of Broken Oaths',
      'Led the countercharge at Blackglass Gate alongside Medo'
    ]
  },
  medo: {
    name: 'Medo the Champion',
    title: 'Arena King of the Sunstone Citadel',
    style:
      'Medo fights with relentless speed, turning every duel into a storm of steel and precision.',
    profile: {
      signatureMove: 'Solar Crescent',
      mentor: 'Master Teren of the Crimson Yard',
      oath: 'A true champion fights for people, not applause.'
    },
    feats: [
      'Won 77 arena bouts without a single surrender',
      'Defeated the twin colossi at Dawnspire',
      'Swore loyalty to Nodin during the Siege of Blackglass Gate'
    ],
    loadout: ['Twin falchions', 'Weighted vambraces', 'Sunstone medallion'],
    quote: 'A true champion fights for people, not applause.'
  }
};

const contentTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8'
};

function sendJson(res, status, data) {
  res.writeHead(status, { 'Content-Type': 'application/json; charset=utf-8' });
  res.end(JSON.stringify(data));
}

async function serveStatic(res, filePath) {
  const ext = path.extname(filePath).toLowerCase();
  const type = contentTypes[ext] || 'application/octet-stream';
  const data = await fs.readFile(filePath);
  res.writeHead(200, { 'Content-Type': type });
  res.end(data);
}

async function handleRequest(req, res) {
  const requestUrl = new URL(req.url, `http://${req.headers.host}`);

  if (requestUrl.pathname === '/api/lore' && req.method === 'GET') {
    return sendJson(res, 200, lore);
  }

  if (requestUrl.pathname === '/api/champions/medo' && req.method === 'GET') {
    return sendJson(res, 200, lore.medo);
  }

  const routeMap = {
    '/': 'index.html',
    '/medo': 'medo.html'
  };

  const mappedPath = routeMap[requestUrl.pathname] || requestUrl.pathname;
  const normalized = path.normalize(mappedPath).replace(/^\.+/, '');
  const resolvedPath = path.join(PUBLIC_DIR, normalized);

  if (!resolvedPath.startsWith(PUBLIC_DIR)) {
    return sendJson(res, 403, { error: 'Forbidden path.' });
  }

  try {
    const stat = await fs.stat(resolvedPath);
    if (stat.isDirectory()) {
      return serveStatic(res, path.join(resolvedPath, 'index.html'));
    }
    return serveStatic(res, resolvedPath);
  } catch {
    try {
      return serveStatic(res, path.join(PUBLIC_DIR, '404.html'));
    } catch {
      return sendJson(res, 404, { error: 'Not found.' });
    }
  }
}

const server = http.createServer((req, res) => {
  handleRequest(req, res).catch((error) => {
    console.error('Request handling error:', error);
    sendJson(res, 500, { error: 'Internal server error.' });
  });
});

server.listen(PORT, () => {
  console.log(`Nodin server running on http://localhost:${PORT}`);
});
