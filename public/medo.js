function renderList(targetId, items) {
  const list = document.getElementById(targetId);
  list.innerHTML = '';

  items.forEach((entry) => {
    const item = document.createElement('li');
    item.innerHTML = entry;
    list.appendChild(item);
  });
}

async function loadMedo() {
  const response = await fetch('/api/champions/medo');
  const medo = await response.json();

  document.getElementById('medo-title').textContent = `${medo.name} — ${medo.title}`;
  document.getElementById('medo-style').textContent = medo.style;
  document.getElementById('medo-quote').textContent = `“${medo.quote}”`;

  renderList('medo-profile', [
    `<strong>Signature Move:</strong> ${medo.profile.signatureMove}`,
    `<strong>Mentor:</strong> ${medo.profile.mentor}`,
    `<strong>Arena Oath:</strong> ${medo.profile.oath}`
  ]);

  renderList('medo-feats', medo.feats);
  renderList('medo-loadout', medo.loadout);
}

loadMedo().catch((error) => {
  console.error(error);
});
