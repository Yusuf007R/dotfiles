local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.color_schemes = {
  carbonfox = {
    foreground = "#f2f4f8",
    background = "#161616",

    cursor_bg = "#b6b8bb",
    cursor_fg = "#f2f4f8",
    cursor_border = "#b6b8bb",

    selection_fg = "#f2f4f8",
    selection_bg = "#2a2a2a",

    ansi = {
      "#282828", "#ee5396", "#25be6a", "#08bdba",
      "#78a9ff", "#be95ff", "#33b1ff", "#dfdfe0",
    },
    brights = {
      "#484848", "#f16da6", "#46c880", "#2dc7c4",
      "#8cb6ff", "#c8a5ff", "#52bdff", "#e4e4e5",
    },
    indexed = {
      [16] = "#3ddbd9",
      [17] = "#ff7eb6",
    },
  },
}

config.color_scheme = "carbonfox"

config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font_with_fallback({ "FiraCode Nerd Font" })

-- Really no tabs:
config.enable_tab_bar = false

-- WSL default domain (this is fine, but note: still goes through ConPTY)
local wsl_domains = wezterm.default_wsl_domains()
config.wsl_domains = wsl_domains
if #wsl_domains > 0 then
  config.default_domain = wsl_domains[1].name
end


config.launch_menu = {
  { label = "PowerShell (pwsh)", args = { "pwsh.exe", "-NoLogo" } },
  { label = "Windows PowerShell", args = { "powershell.exe", "-NoLogo" } },
}

config.keys = {
  { key = "l", mods = "ALT", action = act.ShowLauncher },
}

return config
