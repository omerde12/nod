function renderList(targetId, items) {
  const list = document.getElementById(targetId);
  list.innerHTML = '';

  items.forEach((entry) => {
    const item = document.createElement('li');
    item.innerHTML = entry;
    list.appendChild(item);
  });
}

async function loadNodin() {
  const response = await fetch('/api/lore');
  const data = await response.json();
  const nodin = data.nodin;

  document.getElementById('nodin-title').textContent = `${nodin.name} — ${nodin.title}`;
  document.getElementById('nodin-origin').textContent = nodin.origin;
  document.getElementById('nodin-mission').textContent = nodin.mission;

  renderList('profile-list', [
    `<strong>Age:</strong> ${nodin.profile.age}`,
    `<strong>Homeland:</strong> ${nodin.profile.homeland}`,
    `<strong>Faction:</strong> ${nodin.profile.faction}`,
    `<strong>Motto:</strong> ${nodin.profile.motto}`
  ]);

  renderList(
    'weapon-list',
    nodin.weapons.map(
      (weapon) => `<strong>${weapon.name}</strong> (${weapon.style}) — ${weapon.detail}`
    )
  );

  renderList('milestone-list', nodin.milestones);
}

loadNodin().catch((error) => {
  console.error(error);
});
