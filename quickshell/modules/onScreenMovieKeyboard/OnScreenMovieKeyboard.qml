import "root:/"
import "root:/services"
import "root:/modules/common"
import "root:/modules/common/widgets"
import "root:/modules/common/functions/color_utils.js" as ColorUtils
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Scope { // Scope
    id: root
    property bool pinned: ConfigOptions?.osk.pinnedOnStartup ?? false

    component OskControlButton: GroupButton { // Pin button
        baseWidth: 40
        baseHeight: 40
        clickedWidth: baseWidth
        clickedHeight: baseHeight + 20
        buttonRadius: Appearance.rounding.normal
    }

    Loader {
        id: oskMovieLoader
        active: false
        onActiveChanged: {
            if (!oskMovieLoader.active) {
                Ydotool.releaseAllKeys();
            }
        }
        
        sourceComponent: PanelWindow { // Window
            id: oskMovieRoot
            visible: oskMovieLoader.active

            anchors {
                bottom: false
                left: true
                right: false
                top: true
            }

            function hide() {
                oskMovieLoader.active = false
            }
            exclusiveZone: root.pinned ? implicitHeight - Appearance.sizes.hyprlandGapsOut : 0
            implicitWidth: oskBackground.width + Appearance.sizes.elevationMargin * 2
            implicitHeight: oskBackground.height + Appearance.sizes.elevationMargin * 2
            WlrLayershell.namespace: "quickshell:osk"
            WlrLayershell.layer: WlrLayer.Overlay
            // Hyprland 0.49: Focus is always exclusive and setting this breaks mouse focus grab
            // WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: "transparent"

            mask: Region {
                item: oskBackground
            }


            // Background
            StyledRectangularShadow {
                target: oskBackground
            }
            Rectangle {
                id: oskBackground
                anchors.centerIn: parent
                color: Appearance.colors.colLayer0
                radius: Appearance.rounding.windowRounding
                property real padding: 10
                implicitWidth: oskRowLayout.implicitWidth + padding * 2
                implicitHeight: oskRowLayout.implicitHeight + padding * 2

                Keys.onPressed: (event) => { // Esc to close
                    if (event.key === Qt.Key_Escape) {
                        oskMovieRoot.hide()
                    }
                }

                RowLayout {
                    id: oskRowLayout
                    anchors.centerIn: parent
                    spacing: 5
                    OskContent {
                        id: oskContent
                        Layout.fillWidth: true
                    }
                }
            }

        }
    }

    IpcHandler {
        target: "osk"

        function toggle(): void {
            oskMovieLoader.active = !oskMovieLoader.active
        }

        function close(): void {
            oskMovieLoader.active = false
        }

        function open(): void {
            oskMovieLoader.active = true
        }
    }

    GlobalShortcut {
        name: "oskMovieToggle"
        description: qsTr("Toggles on screen movie keyboard on press")

        onPressed: {
            oskMovieLoader.active = !oskMovieLoader.active;
        }
    }

    GlobalShortcut {
        name: "oskMovieOpen"
        description: qsTr("Opens on screen movie keyboard on press")

        onPressed: {
            oskMovieLoader.active = true;
        }
    }

    GlobalShortcut {
        name: "oskMovieClose"
        description: qsTr("Closes on screen movie keyboard on press")

        onPressed: {
            oskMovieLoader.active = false;
        }
    }

}
