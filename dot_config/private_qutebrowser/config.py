import catppuccin

c.qt.force_software_rendering = "chromium"
config.bind(r",pp", "spawn --userscript qute-bitwarden")
config.load_autoconfig()
config.set("colors.webpage.preferred_color_scheme", "dark")
catppuccin.setup(c, "mocha", True)
config.set("content.user_stylesheets", "~/.config/qutebrowser/css/duckduckgo.css")
