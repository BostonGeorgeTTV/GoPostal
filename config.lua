Config = {}

Config.TextUiStyle = {
    position = "right-center",
    icon = 'bottle',
    style = {
        borderRadius = 3,
        backgroundColor = '#00ffa3',
        color = '#d1135c'
    }
}

Config.TexUiText = {
    startJob = "Inizia il giro",
    retrieve = "Ritira Pacchi",
    delivery = "Consegna",
    garage = "Parcheggia"
}

Config.Vehicle = "boxville2"

Config.item = "package"
Config.takeItem = 20
Config.quantity = 1
Config.money = "money"
Config.reward = {
    a = 700,
    b = 1000,
}

Config.Start = {
    npc = vec4(57.0606, 122.1829, 78.1843, 245.7576),
    coords = vec3(57.6385, 122.0237, 79.1969),
    van = vec4(67.0947, 120.9795, 79.1029, 160.4418),
}

Config.retrive = {
    coords = vec3(1125.8368, -1241.8497, 21.3666),
    AreaRaccolta = vec3(1126.0, -1242.0, 21.0),
    Areasize = vec3(1, 2, 4.0),
    AreaRotation = 35.0,
}

Config.Delivery = {
    {x = -1129.1517, y = 395.020, z = 69.651, isBusy = false },
    {x = -1103.568, y = 284.569, z = 63.094, isBusy = false },
    {x = -1473.558, y = -10.789, z = 54.525, isBusy = false }, 
    {x = -1532.2011, y = -37.736, z = 56.381, isBusy = false },
    {x = -1545.794, y = -33.281, z = 56.891, isBusy = false }, 
    {x = -1464.423, y = 51.018, z = 53.988, isBusy = false }, 
    {x = -1470.730, y = 63.990, z = 51.173, isBusy = false }, 
    {x = -1504.209, y = 44.286, z = 53.951, isBusy = false }, 
    {x = -1585.733, y = 44.503, z = 59.000, isBusy = false }, 
    {x = -1615.332, y = 74.720, z = 60.412, isBusy = false }, 
    {x = -822.115, y = -28.949, z = 37.660, isBusy = false }, 
    {x = -877.125, y = 1.430, z = 43.068, isBusy = false }, 
    {x = -883.502, y = 19.959, z = 43.858, isBusy = false }, 
    {x = -904.483, y = 17.959, z = 45.375, isBusy = false }, 
    {x = -849.538, y = 103.97, z = 51.921, isBusy = false }, 
    {x = -851.218, y = 178.97, z = 68.720, isBusy = false }, 
    {x = -923.231, y = 178.72, z = 65.937, isBusy = false }, 
    {x = -954.205, y = 177.81, z = 64.367, isBusy = false }, 
    {x = -934.734, y = 123.06, z = 55.740, isBusy = false }, 
    {x = -950.383, y = 125.10, z = 56.440, isBusy = false }, 
}

-- translate
Config.translate = {
    ritiro = "Calcolo del giro di consegne . . .",
    consegna = "Consegna in corso . . .",
    postoVan = "Libera il parcheggio!",
    no_item = "Non hai nulla da consegnare!",
    already_delivered = "Hai gia fatto questa consegna!",
    nojob = "Passa prima in magazzino!",
    retrieve = "Ritirando pacchi . . .",
    start = "Inizia il giro di consegne!",
    parkingCar = "riconsegnando il veicolo e i pacchi avanzati . . .",
    alreadyWork = "Stai gia facendo le consegne!",
}