return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      white = "#E1EFFF",
      grey = "#cad7e5",
      background = "#2D2B55",
      backgroundDark = "#1E1E3F",
      foreground = "#A599E9",
      hoverBackground = "#4D21FC",
      contrast = "#FAD000",
      contrastLite = "#FFEE80",
      contrastLiteII = "#FAEFA5",
      highlight = "#FF7200",
      comment = "#B362FF",
      commentsLite = "#c991ff",
      constants = "#FF628C",
      constantsLite = "#ff91ae",
      keywords = "#FF9D00",
      other = "#9EFFFF",
      strings = "#A5FF90",
      stringsLite = "#d2ffc7",
      jsonString = "#92FC79",
      darkerStrings = "#73b264",
      templates = "#75e44c",
      definitions = "#FB94FF",
      invalid = "#EC3A37",
      diffAdded = "#00FF00",
      diffRemoved = "#FF000D",
      matchBracket = "#AD70FC",
      gutter = "#28284E",
      menuBackground = "#1F1F41",
      searchHighlight = "#FFFF03",
      currentSearch = "#ff7300",
      objectKeys = "#80FFBB",
      -- # This should be similar to `comment`
      selectionBackground = "#7d44b2",
      cssEntity = "#3AD900",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.foreground, fg = colors.backgroundDark, gui = "bold" },
        b = { bg = colors.backgroundDark, fg = colors.foreground },
        c = { bg = colors.foreground, fg = colors.background },
      },
      insert = {
        a = { bg = colors.other, fg = colors.backgroundDark, gui = "bold" },
        b = { bg = colors.backgroundDark, fg = colors.foreground },
        c = { bg = colors.other, fg = colors.backgroundDark },
      },
      visual = {
        a = { bg = colors.backgroundDark, fg = colors.commentsLite, gui = "bold" },
        b = { bg = colors.backgroundDark, fg = colors.definitions },
        c = { bg = colors.foreground, fg = colors.backgroundDark },
      },
      command = {
        a = { bg = colors.foreground, fg = colors.backgroundDark, gui = "bold" },
        b = { bg = colors.backgroundDark, fg = colors.foreground },
        c = { bg = colors.foreground, fg = colors.backgroundDark },
      },
      replace = {
        a = { bg = colors.backgroundDark, fg = colors.constants, gui = "bold" },
        b = { bg = colors.backgroundDark, fg = colors.constantsLite },
        c = { bg = colors.foreground, fg = colors.backgroundDark },
      },
      inactive = {
        a = { bg = colors.foreground, fg = colors.backgroundDark, gui = "bold" },
        b = { bg = colors.foreground, fg = colors.backgroundDark },
        c = { bg = colors.foreground, fg = colors.backgroundDark },
      },
    }

-- local colors = {
--       blue = "#65D1FF",
--       green = "#3EFFDC",
--       violet = "#FF61EF",
--       yellow = "#FFDA7B",
--       red = "#FF4A4A",
--       fg = "#c3ccdc",
--       bg = "#112638",
--       inactive_bg = "#2c3043",
--     }

--     local my_lualine_theme = {
--       normal = {
--         a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       insert = {
--         a = { bg = colors.green, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       visual = {
--         a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       command = {
--         a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       replace = {
--         a = { bg = colors.red, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       inactive = {
--         a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
--         b = { bg = colors.inactive_bg, fg = colors.semilightgray },
--         c = { bg = colors.inactive_bg, fg = colors.semilightgray },
--       },
--     }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
