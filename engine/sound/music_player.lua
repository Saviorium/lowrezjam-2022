if not AssetManager then
    error("AssetManager is required for MusicPlayer")
end

local Timer = require("lib.hump.timer")

local MusicPlayer = {
    currentTrack = {
        name = nil,
        source = nil,
        metadata = nil,
        previousPosition = 0,
    },
    rhythmModule = require("engine.sound.rhythm_module"),
    globalMusicVolume = 1,
    fadingVolume = {1},
    fadingTime = 1, -- seconds
    isCurrentlyFading = false,
    fadingTypes = {
        --  _________ _________
        --  old_track|new_track
        "instant",

        --  _________   _________
        --  old_track\./new_track
        "out-in",

        --  _________  _________
        --  old_track\|new_track
        "out-instant",

        -- 1-2-3-4|new_track
        "new-bar",

        -- 1234-1234-1234-1234|new_track
        "forth-bar",
    }
}

function MusicPlayer:loadData(musicData)
    self.musicData = musicData
    if MusicPlayer.rhythmModule then
        MusicPlayer.rhythmModule:initMusicData(self.currentTrack)
    end
    return self
end

function MusicPlayer:play(track, fading)
    if not track and self.currentTrack.name or self.currentTrack.name == track then
        self:_switchToTrackIfNotAlreadyPlaying(self.currentTrack.name)
        return
    end
    if self.isCurrentlyFading then
        return
    end
    if fading == "out-in" then
        self.isCurrentlyFading = true
        Timer.tween(self.fadingTime, self.fadingVolume, {0}, "linear",
            function()
                self:_switchToTrackIfNotAlreadyPlaying(track)
                Timer.tween(self.fadingTime, self.fadingVolume, {1}, "linear",
                    function() self.isCurrentlyFading = false end
                )
            end
        )
        return
    end
    if fading == "out-instant" then
        self.isCurrentlyFading = true
        Timer.tween(self.fadingTime, self.fadingVolume, {0}, "linear",
            function()
                self:_switchToTrackIfNotAlreadyPlaying(track)
                self.fadingVolume = {1}
                self:_setVolume()
                self.isCurrentlyFading = false
            end
        )
        return
    end

    if fading == "new-bar" and self.rhythmModule and self:isPlaying() then
        self.isCurrentlyFading = true
        local timeToWait = self.rhythmModule:getTimeTillBar(1)
        Timer.tween(timeToWait, self.fadingVolume, {1}, "linear",
            function()
                self:_switchToTrackIfNotAlreadyPlaying(track)
                self.fadingVolume = {1}
                self:_setVolume()
                self.isCurrentlyFading = false
            end
        )
        return
    end
    if fading == "forth-bar" and self.rhythmModule and self:isPlaying() then
        self.isCurrentlyFading = true
        local timeToWait = self.rhythmModule:getTimeTillBar(4)
        Timer.tween(timeToWait, self.fadingVolume, {1}, "linear",
            function()
                self:_switchToTrackIfNotAlreadyPlaying(track)
                self.fadingVolume = {1}
                self:_setVolume()
                self.isCurrentlyFading = false
            end
        )
        return
    end
    -- for "instant" and default
    self:_switchToTrackIfNotAlreadyPlaying(track)
end

function MusicPlayer:muteStop()
    if self.currentTrack.source then
        self.currentTrack.source:stop()
    end
end

function MusicPlayer:stop()
    if self.currentTrack.source then
        self.currentTrack.source:stop()
        self.currentTrack = {
            name = nil,
            source = nil,
            metadata = nil
        }
    end
end

function MusicPlayer:setGlobalVolume(volume)
    self.globalMusicVolume = math.clamp(0, volume, 1)
    self:_setVolume()
end

function MusicPlayer:registerRhythmCallback(beatsType, fn)
    if self.rhythmModule then
        self.rhythmModule:registerRhythmCallback(beatsType, fn)
    end
end

function MusicPlayer:getCurrentBeat()
    if not self.rhythmModule then
        return 0
    end
    return self.rhythmModule:getCurrentBeat()
end

function MusicPlayer:getSignature()
    if not self.rhythmModule then
        return 4
    end
    return self.rhythmModule:getSignature()
end

function MusicPlayer:getBpm()
    if not self.rhythmModule then
        return 120
    end
    return self.rhythmModule:getBpm()
end

function MusicPlayer:update(dt)
    Timer.update(dt)
    if self.isCurrentlyFading then
        self:_setVolume()
    end

    if self:isPlaying() and self.currentTrack.metadata.loopPoint then
        local trackPos = self.currentTrack.source:tell()
        if trackPos < self.currentTrack.previousPosition and self.currentTrack.source:isLooping() then
            local loopPoint = self.currentTrack.metadata.loopPoint
            self.currentTrack.source:seek(loopPoint)
            trackPos = loopPoint
        end
        self.currentTrack.previousPosition = trackPos
    end

    if self.rhythmModule then
        self.rhythmModule:update(dt)
    end
end

function MusicPlayer:isPlaying(track)
    if self.currentTrack.source and self.currentTrack.source:isPlaying() then
        if track then
            return self.currentTrack.name == track
        else
            return true
        end
    end
    return false
end

function MusicPlayer:_setVolume()
    if self.currentTrack.source then
        local volume = self.globalMusicVolume
        if self.currentTrack.metadata.volume then
            volume = volume * self.currentTrack.metadata.volume
        end
        volume = volume * self.fadingVolume[1]
        self.currentTrack.source:setVolume(volume)
    end
end

function MusicPlayer:_switchToTrackIfNotAlreadyPlaying(track)
    if self.currentTrack.name == track and self.currentTrack.source then
        if not self.currentTrack.source:isPlaying() then
            self:_playCurrentSource()
        end
        return -- trying to switch to track that is already playing - do nothing
    end
    if self.currentTrack.source then
        self.currentTrack.source:stop()
    end
    local trackData = self.musicData[track]
    if not trackData then
        print("Tried to play music that not exists")
        return
    end
    self.currentTrack.name = track
    self.currentTrack.metadata = trackData
    self.currentTrack.source = AssetManager:getSound(trackData.fileName)
    self.currentTrack.previousPosition = 0,
    self:_playCurrentSource()
end

function MusicPlayer:_playCurrentSource()
    if self.currentTrack.metadata.loop == nil or self.currentTrack.metadata.loop == true then
        self.currentTrack.source:setLooping(true)
    end
    self:_setVolume()
    self.currentTrack.source:play()
end

return function(musicData) return MusicPlayer:loadData(musicData) end
