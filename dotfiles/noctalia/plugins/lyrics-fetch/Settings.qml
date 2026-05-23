import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Services.System

ColumnLayout {
    id: root
    property var pluginApi: null

    property int draftWidth: pluginApi?.pluginSettings?.widgetWidth ?? 215
    property int draftSpeed: pluginApi?.pluginSettings?.scrollSpeed ?? 70
    property string draftMode: pluginApi?.pluginSettings?.scrollMode ?? "always"
    property int draftFontSize: pluginApi?.pluginSettings?.fontSize ?? 10
    property bool draftHideWhenEmpty: pluginApi?.pluginSettings?.hideWhenEmpty ?? true
    property string draftFontFamily: pluginApi?.pluginSettings?.fontFamily ?? "Inter"
    property bool draftAdaptScrollSpeed: pluginApi?.pluginSettings?.adaptScrollSpeed ?? true
    property bool draftHideWhenPaused: pluginApi?.pluginSettings?.hideWhenPaused ?? true
    property string draftVerticalRotationDirection: {
        const savedDirection = pluginApi?.pluginSettings?.verticalRotationDirection;
        if (savedDirection === "auto" || savedDirection === "cw" || savedDirection === "ccw")
            return savedDirection;
        return "auto";
    }

    readonly property bool isBarVertical: Settings.data.bar.position === "left" || Settings.data.bar.position === "right"

    spacing: Style.marginM

    function saveSettings() {
        if (pluginApi) {
            pluginApi.pluginSettings.widgetWidth = draftWidth;
            pluginApi.pluginSettings.scrollSpeed = draftSpeed;
            pluginApi.pluginSettings.scrollMode = draftMode;
            pluginApi.pluginSettings.adaptScrollSpeed = draftAdaptScrollSpeed;
            pluginApi.pluginSettings.hideWhenPaused = draftHideWhenPaused;
            pluginApi.pluginSettings.verticalRotationDirection = draftVerticalRotationDirection;
            pluginApi.pluginSettings.fontSize = draftFontSize;
            pluginApi.pluginSettings.hideWhenEmpty = draftHideWhenEmpty;
            // Save the selected font
            pluginApi.pluginSettings.fontFamily = draftFontFamily;
            pluginApi.saveSettings();
        }
    }

    NSearchableComboBox {
        label: pluginApi?.tr("settings.font.title")
        description: pluginApi?.tr("settings.font.desc")
        Layout.fillWidth: true

        model: FontService.availableFonts

        currentKey: draftFontFamily
        placeholder: pluginApi?.tr("settings.font.placeholder")
        searchPlaceholder: pluginApi?.tr("settings.font.search-placeholder")
        popupHeight: 300

        onSelected: key => draftFontFamily = key
    }

    NLabel {
        label: pluginApi?.tr("settings.font.size")
        description: pluginApi?.tr("settings.font.size-desc")
    }

    RowLayout {
        Layout.fillWidth: true
        NSlider {
            Layout.fillWidth: true
            from: 8
            to: 32
            value: draftFontSize
            onValueChanged: draftFontSize = value
        }
        NText {
            text: Math.round(draftFontSize) + "pt"
        }
    }

    NDivider {
        Layout.fillWidth: true
    }

    NLabel {
        label: pluginApi?.tr("settings.width")
    }
    RowLayout {
        Layout.fillWidth: true
        NSlider {
            Layout.fillWidth: true
            from: 100
            to: 500
            value: draftWidth
            onValueChanged: draftWidth = value
        }
        NText {
            text: Math.round(draftWidth) + "px"
        }
    }

    NLabel {
        label: pluginApi?.tr("settings.scroll.speed")
    }
    RowLayout {
        Layout.fillWidth: true
        NSlider {
            Layout.fillWidth: true
            from: 10
            to: 200
            value: draftSpeed
            onValueChanged: draftSpeed = value
        }
        NText {
            text: Math.round(draftSpeed) + " px/s"
        }
    }

    NComboBox {
        label: pluginApi?.tr("settings.scroll.mode.title")
        Layout.fillWidth: true
        model: [
            {
                name: pluginApi?.tr("settings.scroll.mode.always"),
                key: "always"
            },
            {
                name: pluginApi?.tr("settings.scroll.mode.hover"),
                key: "hover"
            },
            {
                name: pluginApi?.tr("settings.scroll.mode.never"),
                key: "none"
            }
        ]
        currentKey: draftMode
        onSelected: key => draftMode = key
    }

    NToggle {
        label: pluginApi?.tr("settings.scroll.adapt")
        description: pluginApi?.tr("settings.scroll.adapt-desc")
        checked: draftAdaptScrollSpeed
        onToggled: newState => {
            draftAdaptScrollSpeed = newState;
        }
    }

    NToggle {
        label: pluginApi?.tr("settings.hide-when-empty")
        checked: draftHideWhenEmpty
        onToggled: newState => {
            draftHideWhenEmpty = newState;
        }
    }

    NComboBox {
        visible: root.isBarVertical
        label: pluginApi?.tr("settings.vertical-rotation.title")
        description: pluginApi?.tr("settings.vertical-rotation.description")
        Layout.fillWidth: true
        model: [
            {
                name: pluginApi?.tr("settings.vertical-rotation.auto"),
                key: "auto"
            },
            {
                name: pluginApi?.tr("settings.vertical-rotation.ccw"),
                key: "ccw"
            },
            {
                name: pluginApi?.tr("settings.vertical-rotation.cw"),
                key: "cw"
            }
        ]
        currentKey: draftVerticalRotationDirection
        onSelected: key => draftVerticalRotationDirection = key
    }

    NToggle {
        label: pluginApi?.tr("settings.hide-when-paused")
        checked: draftHideWhenPaused
        onToggled: newState => {
            draftHideWhenPaused = newState;
        }
    }
}
