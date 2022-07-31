local fonts = {
	thin = { -- self-made font drawn by Savioirum, inspired by m3x6, CC BY-SA 4.0
		font = love.graphics.newImageFont('data/fonts/lowres_font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-=_+[]{};\':»,./<>?\\|*@#$%^&()!' ), height = 7, width = 4}
}

fonts.thin.font:setFilter( "nearest", "nearest" )

return fonts