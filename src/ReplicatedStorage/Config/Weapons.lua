local Weapons = {
    Pistol = {
        Cost = 0,
        Damage = 12,
        FireRate = 0.25,
        Range = 180,
        CritChance = 0.05,
        CritMultiplier = 1.7,
    },
    SMG = {
        Cost = 350,
        Damage = 9,
        FireRate = 0.08,
        Range = 150,
        CritChance = 0.04,
        CritMultiplier = 1.5,
    },
    Shotgun = {
        Cost = 650,
        Damage = 11,
        Pellets = 8,
        FireRate = 0.9,
        Range = 70,
        CritChance = 0.02,
        CritMultiplier = 1.8,
    },
    Rifle = {
        Cost = 1100,
        Damage = 30,
        FireRate = 0.5,
        Range = 260,
        CritChance = 0.1,
        CritMultiplier = 2.2,
    },
    PlasmaCaster = {
        Cost = 2200,
        Damage = 65,
        FireRate = 0.9,
        Range = 240,
        CritChance = 0.15,
        CritMultiplier = 2.5,
    },
}

return Weapons
