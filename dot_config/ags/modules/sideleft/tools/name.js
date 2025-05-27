const { Gtk } = imports.gi;
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import { setupCursorHover } from "../../.widgetutils/cursorhover.js";
const { execAsync, exec } = Utils;
const { Box, Button, CenterBox, EventBox, Icon, Label, Scrollable } = Widget;
const hostname = Variable("initial-value", {
  poll: [1000000000, "fish -c 'echo $USER@$hostname'"],
});
export default () =>
  Box({
    className: "txt sidebar-module techfont",
    children: [
      Label({
        label: hostname.bind().as((value) => value.toString()),
      }),
      Box({ hexpand: true }),
      Button({
        className: "sidebar-module-btn-arrow",
        onClicked: () =>
          execAsync(["xdg-open", "https://github.com/extouchtriangle"]).catch(
            print,
          ),
        child: Icon({
          className: "txt txt-norm",
          icon: "github-symbolic",
        }),
        setup: setupCursorHover,
      }),
    ],
  });
