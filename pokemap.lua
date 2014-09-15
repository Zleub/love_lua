return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  properties = {},
  tilesets = {
    {
      name = "60234",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "tilesets/60234.png",
      imagewidth = 976,
      imageheight = 1360,
      properties = {},
      tiles = {
        {
          id = 313,
          properties = {
            ["stairs"] = "1"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        8, 1588, 1588, 1588, 1588, 1588, 1588, 1588, 1588, 1589,
        1648, 314, 252, 252, 252, 252, 252, 1227, 252, 1650,
        1648, 252, 314, 252, 252, 314, 252, 252, 252, 1650,
        1648, 245, 246, 252, 252, 252, 252, 252, 252, 1650,
        1648, 367, 368, 252, 252, 314, 252, 252, 252, 1650,
        1648, 252, 252, 252, 252, 252, 252, 252, 133, 1650,
        1648, 252, 1618, 1619, 1619, 1621, 252, 252, 194, 1650,
        1648, 252, 1628, 1629, 1752, 1631, 252, 252, 252, 1650,
        1648, 252, 252, 252, 252, 252, 252, 252, 252, 1650,
        1709, 1710, 1710, 1710, 1710, 1710, 1710, 1710, 1710, 1711
      }
    }
  }
}
