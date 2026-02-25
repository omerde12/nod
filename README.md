# Battle for Brainrots (Roblox)

This repository contains a complete production-ready starter kit and design package for a Roblox wave/survival game called **Battle for Brainrots**.

## What is included

- Full game design spec (core loop, rarity system, progression, economy, map, balancing).
- Server-authoritative spawning, combat, and reward systems in Roblox Lua.
- Config-driven rarity + weapon + brainrot data tables.
- Client input script for combat interactions.
- Implementation roadmap so you can ship in phases.

## Folder layout

- `docs/GAME_DESIGN.md` — detailed game design document.
- `src/ReplicatedStorage/Config` — game tuning data.
- `src/ReplicatedStorage/Modules` — shared utility + factory logic.
- `src/ServerScriptService` — server systems.
- `src/StarterPlayer/StarterPlayerScripts` — player-side controls.

## How to use this in Roblox Studio

1. Create a Roblox place named `Battle for Brainrots`.
2. Recreate this folder structure in Studio services:
   - `ReplicatedStorage/Config`
   - `ReplicatedStorage/Modules`
   - `ServerScriptService`
   - `StarterPlayer/StarterPlayerScripts`
3. Copy each Lua file into corresponding Script/ModuleScript.
4. In `ReplicatedStorage`, create a folder called `Remotes` with:
   - `RemoteEvent` named `AttackRequest`
   - `RemoteEvent` named `CashInRequest`
   - `RemoteEvent` named `Notify`
5. Create map parts/folders:
   - `Workspace/BrainrotSpawnPoints` with multiple anchored parts.
   - `Workspace/CashInZone` part with touched detector.
6. Add leaderstats display UI or use Roblox default leaderboard.
7. Playtest and tune config values in `Config` modules.

## Notes

- This starter is intentionally server-authoritative to reduce exploit abuse.
- Brainrots are NPC model placeholders; swap in custom rigs/animations/VFX for final polish.
- DataStore writes are included as a safe baseline and can be expanded for inventory/progression.
