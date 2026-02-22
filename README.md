# Nodin & Medo Full-Stack Website

A beginner-friendly Node.js website with:

- `GET /` -> Nodin page
- `GET /medo` -> Medo page
- `GET /api/lore` -> all lore JSON
- `GET /api/champions/medo` -> Medo JSON

## 1) Run locally

```bash
npm start
```

Open in browser:

- http://localhost:3000/
- http://localhost:3000/medo

## 2) If you're on Windows PowerShell

Use your real project path (example):

```powershell
cd "C:\Users\YourName\Desktop\nod"
npm start
```

## 3) Upload to GitHub

Create an empty repo on GitHub first, then run:

```bash
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin HEAD
```

If `origin` already exists:

```bash
git remote set-url origin https://github.com/<your-username>/<your-repo>.git
git push -u origin HEAD
```
