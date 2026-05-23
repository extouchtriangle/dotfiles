hl.config({
general  = {
  col = {
    active_border = "rgba(D4E5ED39)",
    inactive_border = "rgba(7F949C30)"
  }
},

misc={
    background_color = "rgba(05161BFF)"
}
})

hl.window_rule({ -- not sure how to syntax "pin 1"
    match        = { pin = 1 },
    border_color = "rgba(40D7FFAA) rgba(40D7FF77)",
})
