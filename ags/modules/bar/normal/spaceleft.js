import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Brightness from "../../../services/brightness.js";
import Indicator from "../../../services/indicator.js";

const WindowTitle = async () => {
  try {
    const Hyprland = (
      await import("resource:///com/github/Aylur/ags/service/hyprland.js")
    ).default;
    return Widget.Scrollable({
      hexpand: true,
      vexpand: true,
      hscroll: "automatic",
      vscroll: "never",
      child: Widget.Box({
        vertical: true,
        children: [
          Widget.Label({
            xalign: 0,
            truncate: "end",
            maxWidthChars: 1, // Doesn't matter, just needs to be non negative
            className: "bar-wintitle-txt",
            setup: (self) => {
              self.hook(Hyprland.active.client, (label) => {
                label.label =
                  Hyprland.active.client.class.length === 0
                    ? `Workspace ${Hyprland.active.workspace.id}`
                    : Hyprland.active.client.class;
              });
              self.hook(Hyprland.active.workspace, (label) => {
                // Hyprland.active.client
                label.label =
                  Hyprland.active.client.class.length === 0
                    ? `Workspace ${Hyprland.active.workspace.id}`
                    : Hyprland.active.client.class;
              });
            },
          }),
        ],
      }),
    });
  } catch {
    return null;
  }
};

export default async (monitor = 0) => {
  const optionalWindowTitleInstance = await WindowTitle();
  return Widget.EventBox({
    onScrollUp: () => {
      Indicator.popup(1); // Since the brightness and speaker are both on the same window
      Brightness[monitor].screen_value += 0.05;
    },
    onScrollDown: () => {
      Indicator.popup(1); // Since the brightness and speaker are both on the same window
      Brightness[monitor].screen_value -= 0.05;
    },
    onPrimaryClick: () => {
      App.toggleWindow("sideleft");
    },
    onSecondaryClick: () => toggleWindowOnAllMonitors("osk-watch"), // Toggle OSK on right-click
    child: Widget.Box({
      homogeneous: false,
      children: [
        Widget.Box({ className: "bar-corner-spacing" }),
        Widget.Overlay({
          overlays: [
            Widget.Box({ hexpand: true }),
            Widget.Box({
              className: "bar-sidemodule",
              hexpand: true,
              children: [
                Widget.Box({
                  vertical: true,
                  className: "bar-space-button",
                  children: [optionalWindowTitleInstance],
                }),
              ],
            }),
          ],
        }),
      ],
    }),
  });
};
