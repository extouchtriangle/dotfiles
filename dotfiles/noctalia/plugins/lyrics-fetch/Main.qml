import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons

Item {
    id: root

    property var pluginApi: null
    property string currentTitle: ""
    property string currentPlayer: ""
    property string currentArtist: ""
    property string currentAlbum: ""
    property real currentLength: 0
    property real currentPosition: 0
    property string currentStatus: "Stopped"
    property string tempTitle: ""
    property string tempPlayer: ""
    property string tempArtist: ""
    property string tempAlbum: ""
    property string tempPosition: ""
    property real tempLength: 0
    property var songLyrics: []
    property int songIndex: -2
    property int lyricInterval: 0
    property bool isLoading: false
    property string lastLyric: ""
    property bool hideWhenPaused: pluginApi?.pluginSettings?.hideWhenPaused ?? false
    property bool hideWhenEmpty: pluginApi?.pluginSettings?.hideWhenEmpty ?? true

    property string currentLyric: {
        if (currentStatus === "Stopped" || currentStatus === "")
            if (hideWhenEmpty)
                return ""
            else
                return pluginApi?.tr("lyrics.stopped")
        if (currentStatus === "Paused") {
            if (hideWhenPaused)
                return ""
            else
                return pluginApi?.tr("lyrics.paused")
        }
        if (isLoading)
            return pluginApi?.tr("lyrics.loading")
        if (lastLyric !== "")
            return lastLyric
        return "​"
    }

    function getLyricIndex() {
        const pos = root.currentPosition
        const lyrics = root.songLyrics
        var start = 0
        var len = lyrics.length

        if (len <= 1) {
            return -2
        }
        if (pos > lyrics[len-1].time || pos < 0) {
            return len-1
        }
        if (pos < lyrics[0].time) {
            return -1
        }
        while (true) {
            if (len == 1) {
                return start
            }
            const len2 = Math.floor(len/2)
            if (pos < lyrics[start + len2].time) {
                len = len2
            } else {
                len -= len2
                start += len2
            }
        }
    }

    Process {
        id: songSeekProc
        command: ['sh', '-c', 'playerctl position -F | while IFS= read -r line ; do   echo "$line" ;   playerctl status ; done']
        running: true
        property int lastPosition: 0
        property string lastState: ""
        property bool canSeek: false
        stdout: SplitParser {
            onRead: data => {
                const pos = Math.floor(parseFloat(data) * 100) / 100
                if (data === "Stopped") {
                    data = "Playing"
                }
                Logger.d("songSeekProc", "data:", data)
                Logger.d("songSeekProc", "lastState:", songSeekProc.lastState)

                Logger.d("songSeekProc", "playing:", data === "Playing")
                Logger.d("songSeekProc", "wasPlaying:", songSeekProc.lastState === "Playing")
                if (data === "Playing" && songSeekProc.lastState === "Playing") {
                    Logger.d("songSeekProc", "seeked")
                    root.currentPosition = songSeekProc.lastPosition
                    root.songIndex = -2
                    root.lyricInterval = 0
                    lyricsTimer.restart()
                }
                if (!isNaN(pos)) {
                    songSeekProc.lastPosition = pos
                } else {
                    songSeekProc.lastState = data
                }
            }
        }
    }

    Process {
        id: songDetailsProc
        command: ["playerctl", "metadata", "--format", "{{ playerName }}:::{{ status }}:::{{ xesam:artist }}:::{{ xesam:title }}:::{{ album }}:::{{ mpris:length / 10000 }}", "-F"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const parts = data.trim().split(":::");
                const player = parts[0] || "";
                const status = parts[1] || "";
                const artist = parts[2] || "";
                const title = parts[3] || "";
                const album = parts[4] || "";
                const length = Math.round(parts[5]) / 100.0 || 0;

                if (!status || !artist || !player || !title) {
                    return;
                }

                if (artist === root.currentArtist && title === root.currentTitle && player === root.currentPlayer && album == root.currentAlbum) {
                    root.currentStatus = status
                    const pos = root.currentPosition
                    if (status === "Playing") {
                        songPositionProc.running = true
                    } else if (status === "Paused") {
                        // Logger.d("songDetailsProc", "song paused")
                        root.songIndex--
                        lyricsTimer.stop()
                    } else if (status === "Stopped") {
                        lastLyric = ""
                    }
                    return
                }

                // Logger.d("songDetailsProc", "status", status)
                // Logger.d("songDetailsProc", "current status", root.currentStatus)
                if (status === "Playing") {// && root.currentStatus !== "Playing") {
                    root.isLoading = true
                    root.tempArtist = artist
                    root.tempPlayer = player
                    root.tempTitle = title
                    root.tempLength = length
                    root.tempAlbum = album
                    fetchLyricProc.running = true;
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                root.currentStatus = "Stopped"
                songDetailsProc.running = true
            }
        }
    }

    Process {
        id: songPositionProc
        command: ["playerctl", "--player", root.currentPlayer, "position", "-F"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                const pos = root.currentPosition
                root.currentPosition = parseFloat(data)
                // Logger.d("songPositionProc", "raw:", data)
                // Logger.d("songPositionProc", "old:", pos)
                // Logger.d("songPositionProc", "new:", root.currentPosition)
                // Logger.d("songPositionProc", "loading:", root.isLoading)

                if (root.isLoading) {
                    root.isLoading = false
                    if (root.currentPosition == 0) {
                        root.songIndex = -1
                    } else {
                        root.songIndex = -2
                    }
                } else {
                    if (root.currentPosition !== pos) {
                        root.songIndex = -2
                    }
                }
                root.lyricInterval = 0

                lyricsTimer.start()

                songPositionProc.running = false
            }
        }
    }

    Process {
        id: fetchLyricProc
        command: ["curl", "https://lrclib.net/api/get?track_name=" + tempTitle.replace(/ /g, "+") + "&artist_name=" + tempArtist.replace(/ /g, "+").replace(/，/g, ",") + "&album_name=" + tempAlbum.replace(/ /g, "+") + "&duration=" + tempLength]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                // Logger.d("fetchLyricProc", "fetching lyrics...")
                // Logger.d("fetchLyricProc", "https://lrclib.net/api/get?track_name=" + tempTitle.replace(/ /g, "+") + "&artist_name=" + tempArtist.replace(/ /g, "+").replace(/，/g, ",") + "&album_name=" + tempAlbum.replace(/ /g, "+") + "&duration=" + tempLength)
                const output = this.text
                // Logger.d("fetchLyricProc", "output:", output)

                var lyrics = ""
                try {
                    lyrics = JSON.parse(output)?.syncedLyrics?.toString() || ""
                } catch (e) {
                    Logger.e("LyricsFetch", "Fetching Lyrics | Error parsing JSON:", e)
                }
                if (!lyrics) {
                    Logger.e("LyricsFetch", "Fetchingn Lyrics | No synced lyrics available")
                    root.isLoading = false
                    root.lastLyric = ""
                    return
                }
                const regexp = /\[[0-9]{2}:[0-9]{2}.[0-9]{2}\]/g
                var match;
                const syncTimes = []
                const syncIndex = []
                while ((match = regexp.exec(lyrics)) !== null) {
                    syncTimes.push(match[0]);
                    syncIndex.push(match.index);
                }
                var lyricArr = []
                for (var i = 0; i < syncTimes.length; i++) {
                    const lyric = lyrics.slice(syncIndex[i]+10, syncIndex[i+1] ?? lyrics.length).trim()
                    const timestamp = syncTimes[i].slice(1,9)
                    lyricArr.push({"time": parseInt(timestamp.slice(0,2)) * 60 + parseFloat(timestamp.slice(3)), "lyric": lyric.trim()})
                    // Logger.d("fetchLyricProc", "timestamp:", parseInt(timestamp.slice(0,2)) * 60.0 + parseFloat(timestamp.slice(3)), "lyric:", lyric.trim())
                }
                // Logger.d("fetchLyricProc", "lyrics:", JSON.stringify(lyricArr))
                root.songLyrics = lyricArr

                // root.isLoading = false
                root.currentArtist = root.tempArtist
                root.currentPlayer = root.tempPlayer
                root.currentTitle = root.tempTitle
                root.currentLength = root.tempLength
                root.currentAlbum = root.tempAlbum
                root.currentStatus = "Playing"

                songPositionProc.running = true
                fetchLyricProc.running = false
            }
        }
    }

Timer {
    id: lyricsTimer
    // 200ms is the "sweet spot" for lyrics: frequent enough to feel
    // snappy, but light enough to not peg the CPU.
    interval: 200
    repeat: true
    running: root.currentStatus === "Playing" && root.songLyrics.length > 0

    onTriggered: {
        // 1. Sync the internal position with the player occasionally
        // to prevent the float value from drifting.
        if (root.songIndex % 5 === 0) {
            songPositionProc.running = true
        } else {
            // Manually increment our tracked position by the timer interval
            root.currentPosition += (interval / 1000)
        }

        // 2. Determine what the lyric index SHOULD be right now
        const expectedIndex = getLyricIndex()

        // 3. Only update the UI if the index has actually changed
        if (expectedIndex !== root.songIndex) {
            root.songIndex = expectedIndex

            if (expectedIndex === -1) {
                root.lastLyric = "" // Pre-song / Intro
            } else if (expectedIndex >= 0) {
                root.lastLyric = root.songLyrics[expectedIndex]?.lyric ?? ""
            }
        }
    }
}
}
