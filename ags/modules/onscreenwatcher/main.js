import PopupWindow from "../.widgethacks/popupwindow.js";
import OnScreenKeyboard from "./onscreenwatcher.js";

export default (id) =>
  PopupWindow({
    monitor: id,
    anchor: ["top", "left"],
    name: `osk-watch${id}`,
    showClassName: "osk-watch-show",
    hideClassName: "osk-watch-hide",
    child: OnScreenKeyboard({ id: id }),
  });
