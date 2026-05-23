hl.unbind("SUPER + E")
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + B")
hl.unbind("SUPER + T")
hl.unbind("SUPER + C")
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER+ SHIFT + K")
hl.unbind("SUPER + SHIFT + L")
hl.unbind("SUPER + SHIFT + S")
hl.unbind("Ctrl + SUPER + S")
hl.unbind("Ctrl + SUPER + F")




for i = 1, 10 do
 local numberkey = {10,11,12,13,14,15,16,17,18,19}
 hl.bind("SUPER + SHIFT + code:"..numberkey[i], hl.dsp.window.move({ workspace = i, follow = true}) )
end
for i = 1, 4 do
 local arrowkey = {"h","l","k","j"}
 local focusdir = {"l","r","u","d"}
 hl.bind("SUPER + "..arrowkey[i], hl.dsp.focus({direction = focusdir[i]}) )
end
for i = 1, 4 do
 local arrowkey = {"h","l","k","j"}
 local focusdir = {"l","r","u","d"}
 hl.bind("SUPER + SHIFT + "..arrowkey[i], hl.dsp.window.move({direction = focusdir[i]}) )
end

hl.bind("SUPER + E",hl.dsp.exec_cmd("emacsclient -c -a ''"))
