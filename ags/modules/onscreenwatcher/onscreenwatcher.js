const { Gtk } = imports.gi;
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";

const { Box, EventBox, Button } = Widget;
const { execAsync } = Utils;
import { MaterialIcon } from "../.commonwidgets/materialicon.js";
import { setupCursorHoverGrab } from "../.widgetutils/cursorhover.js";

const TopDecor = () =>
  Box({
    vertical: true,
    children: [
      Box({
        hpack: "center",
        className: "osk-dragline",
        homogeneous: true,
        children: [
          EventBox({
            setup: setupCursorHoverGrab,
          }),
        ],
      }),
    ],
  });

const KeyboardItself = () => {
  return Box({
    vertical: true,
    className: "spacing-v-5",
    children: [
      Box({
        vertical: false,
        className: "spacing-h-5",
        children: [
          Button({
            className: "osk-key osk-key-arrow",
            child: MaterialIcon("arrow_back", "largest"),
            css: `
              font-size: 36px;
              min-width: 4rem; /* Larger button width */
              min-height: 4rem; /* Larger button height */
            `,
            setup: (button) => {
              button.connect("pressed", () => {
                execAsync(`ydotool key 105:1`).catch(print); // Left arrow keycode
              });
              button.connect("clicked", () => {
                execAsync(`ydotool key 105:0`).catch(print);
              });
            },
          }),
          Button({
            className: "osk-key osk-key-space",
            child: MaterialIcon("space_bar", "largest"),
            css: `
              font-size: 36px;
              min-width: 8rem; /* Larger spacebar width */
              min-height: 4rem; /* Larger spacebar height */
            `,
            setup: (button) => {
              button.connect("pressed", () => {
                execAsync(`ydotool key 57:1`).catch(print); // Spacebar keycode
              });
              button.connect("clicked", () => {
                execAsync(`ydotool key 57:0`).catch(print);
              });
            },
          }),
          Button({
            className: "osk-key osk-key-arrow",
            child: MaterialIcon("arrow_forward", "largest"),
            css: `
              font-size: 36px;
              min-width: 4rem; /* Larger button width */
              min-height: 4rem; /* Larger button height */
            `,
            setup: (button) => {
              button.connect("pressed", () => {
                execAsync(`ydotool key 106:1`).catch(print); // Right arrow keycode
              });
              button.connect("clicked", () => {
                execAsync(`ydotool key 106:0`).catch(print);
              });
            },
          }),
        ],
      }),
    ],
  });
};

const KeyboardWindow = () =>
  Box({
    vexpand: true,
    hexpand: true,
    vertical: true,
    className: "osk-window spacing-v-5",
    children: [
      TopDecor(),
      Box({
        className: "osk-body spacing-h-10",
        children: [KeyboardItself()],
      }),
    ],
    setup: (self) =>
      self.hook(App, (self, name, visible) => {
        if (!name) return;
        if (name.startsWith("osk-watch") && visible) {
          self.setCss(`margin-bottom: -0px;`);
        }
      }),
  });

export default ({ id }) => {
  const kbWindow = KeyboardWindow();
  const gestureEvBox = EventBox({ child: kbWindow });
  const gesture = Gtk.GestureDrag.new(gestureEvBox);
  gesture.connect("drag-begin", async () => {
    try {
      const Hyprland = (
        await import("resource:///com/github/Aylur/ags/service/hyprland.js")
      ).default;
      Hyprland.messageAsync("j/cursorpos")
        .then((out) => {
          gesture.startY = JSON.parse(out).y;
        })
        .catch(print);
    } catch {
      return;
    }
  });
  gesture.connect("drag-update", async () => {
    try {
      const Hyprland = (
        await import("resource:///com/github/Aylur/ags/service/hyprland.js")
      ).default;
      Hyprland.messageAsync("j/cursorpos")
        .then((out) => {
          const currentY = JSON.parse(out).y;
          const offset = gesture.startY - currentY;

          if (offset > 0) return;

          kbWindow.setCss(`
                margin-bottom: ${offset}px;
            `);
        })
        .catch(print);
    } catch {
      return;
    }
  });
  gesture.connect("drag-end", () => {
    var offset = gesture.get_offset()[2];
    if (offset > 50) {
      App.closeWindow(`osk-watch${id}`);
    } else {
      kbWindow.setCss(`
            transition: margin-bottom 170ms cubic-bezier(0.05, 0.7, 0.1, 1);
            margin-bottom: 0px;
        `);
    }
  });
  return gestureEvBox;
};
