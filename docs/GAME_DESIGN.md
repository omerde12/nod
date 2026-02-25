# Battle for Brainrots — Complete Design Package

## 1) High Concept

**Battle for Brainrots** is a session-based co-op PvE game where players hunt absurd "brainrot" enemies of varying rarities. Harder rarities are tankier, deadlier, and more valuable. Players must decide between:

- **Cash In Now** (instant safe payout), or
- **Carry/Process for Passive Income** (higher risk, higher long-term reward).

Players spend earnings on better weapons, survivability upgrades, and utility to survive escalating waves and rare spawns.

## 2) Core Gameplay Loop

1. Enter arena and gear up.
2. Brainrots spawn with weighted rarity odds.
3. Fight and eliminate brainrots.
4. Pick up drops/cores.
5. Choose:
   - Cash in at extractor for immediate coins.
   - Process core at generator for passive income over time.
6. Spend coins in weapon shop.
7. Survive stronger waves and chase ultra-rare spawns.

## 3) Progression Pillars

- **Weapon progression:** pistol → SMG → shotgun → rifle → exotic.
- **Build progression:** damage, reload, movement, crit chance.
- **Session mastery:** movement routes, prioritization, teamwork.
- **Prestige loop (optional):** reset gear for permanent multipliers/cosmetics.

## 4) Brainrot Rarity System

Example rarity ladder:

- Common
- Uncommon
- Rare
- Epic
- Legendary
- Mythic
- Divine

Rarity controls:

- Spawn chance
- Health multiplier
- Damage multiplier
- Move speed
- Reward on kill
- Passive income value

## 5) Combat & Difficulty

### Combat model
- Hitscan or projectile weapons.
- Server validates hits and computes damage.
- Headshot/crit multipliers supported by weapon config.

### Difficulty scaling
- Global threat level increases every X seconds.
- Spawn budget scales by players in server.
- Higher threat unlocks upper rarity bands.

### Anti-exploit
- Server-authoritative damage and rewards.
- Remote event throttling.
- Sanity checks for distance, weapon cooldown, and line-of-sight.

## 6) Economy Design

Two reward channels:

1. **Instant Cash-In:**
   - Guaranteed payout.
   - Low risk, lower total return.

2. **Passive Processor:**
   - Insert captured core.
   - Generates coins every interval for N ticks.
   - Core can be lost if processor is attacked (optional hardcore mode).

Sinks:
- Weapons
- Ammo refill
- Perks
- Revives
- Utility deployables

## 7) Map Design (One Full Map)

### Map: Neon Scrap District

Zones:
- **Central Hub:** shop, cash-in extractor, passive processor.
- **3 Combat Lanes:** alleys with different pathing + elevation.
- **Rooftop Route:** risk path with elite spawns.
- **Sewer Shortcut:** flank path with ambush spawns.
- **Boss Yard:** opens at high threat.

Design goals:
- Clear sightlines with intermittent cover.
- Safe-ish hub but not fully invulnerable.
- Multiple spawn points preventing stale camping.

## 8) UI/UX

- Top bar: coins, DPS, threat level, wave timer.
- Left panel: active cores in inventory.
- Right panel: kill feed + rarity popups.
- Shop UI with stat comparison and lock states.
- Damage numbers color-coded by rarity.

## 9) Content Roadmap

### Phase 1 (MVP)
- 5 rarities
- 4 weapons
- 1 map
- cash-in + passive processor

### Phase 2
- Daily quests
- Boss events
- Perks/traits

### Phase 3
- Prestige
- Cosmetic brainrot index
- Leaderboards/events

## 10) Balancing Baselines

- TTK target by rarity:
  - Common: 0.8–1.5s
  - Rare: 2–4s
  - Legendary: 6–10s
  - Mythic+: team focus required
- Reward-to-time ratio should always justify chasing rarer enemies.
- Prevent single best weapon dominance by using niche roles.

## 11) Technical Architecture

- Shared configs in `ReplicatedStorage/Config`.
- Server services for spawns/combat/economy.
- Client handles input, effects, and UI.
- DataStore for persistent coins/unlocks.

## 12) Monetization (Fair)

- Cosmetic-only battle pass.
- Emotes, kill effects, weapon skins.
- Optional QoL boosts that do not hard paywall core progression.

## 13) Launch Checklist

- Load testing with 10+ concurrent players.
- Exploit test pass for remotes.
- Economy inflation checks.
- Save/load failover tests.
- Spawn pathing edge-case cleanup.
