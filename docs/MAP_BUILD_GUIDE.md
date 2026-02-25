# Neon Scrap District — Build Guide

Use this to quickly block out a playable map in Roblox Studio.

## Workspace hierarchy

- Workspace
  - `BrainrotSpawnPoints` (Folder)
  - `ActiveBrainrots` (Folder, auto-created if missing)
  - `CashInZone` (Part)
  - `ProcessorZone` (Part)
  - `ShopZone` (Part)

## Recommended baseplate dimensions

- Arena footprint: `520 x 520` studs.
- Vertical variation: 3 elevation levels (+0, +18, +36).

## Spawn point placement

Create at least 18 spawn points:

- Lane A (North alleys): 6 points.
- Lane B (East scrapyard): 6 points.
- Lane C (West rooftops): 6 points.

Distance each spawn point 45+ studs from Hub center.

## Hub layout

At map center (0,0,0):
- `CashInZone`: size 18x2x18.
- `ProcessorZone`: size 14x2x14.
- `ShopZone`: size 16x2x16.

Put waist-high cover around hub edges to reduce spawn camping.

## Traversal

- Add 2 stair towers to rooftop route.
- Add sewer tunnel (height ~12 studs) connecting west to east lanes.
- Add jump shortcuts with small risk gaps.

## Lighting/audio

- Night setting with neon accents.
- Ambient machine hum near processor.
- Distinct stinger for Legendary+ spawns.

## Performance budget

- Keep total parts under ~6k for low-end device compatibility.
- Prefer mesh reuse and texture atlases.
