Config = {}

-- Car BlackList
Config.BlockedVehicles = {
    "rhino",
    "hydra",
    "lazer",
    "buzzard",
    "barracks",
    "barracks2",
    "barracks3",
    "besra",
    "titan",
    "jet"
}

-- Group exception
Config.ExemptGroups = {
    "fonda",
    "_dev"
}

-- Delay to load
Config.CheckDelay = 1000 -- en ms

-- ESX (true = Legacy, false = old es_extended like es_extended_1.1.0)
Config.UseESXLegacy = false