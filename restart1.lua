local composer = require( "composer" )
local scene = composer.newScene()
_W=display.contentWidth
_H=display.contentHeight



function scene:create( event )


   local sceneGroup = self.view













end















function scene:show( event )
	local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
--	composer.removeScene("game")
  composer.removeScene("game2")
  composer.gotoScene("game2")


end
end



local function onKeyEvent( event )
  if (event.keyName == "back") and (platformName == "Android") then
    return true
  end

  return false
end


function scene:hide( event )


local phase = event.phase

   if ( phase == "will" ) then
     







  end


end






function scene:destroy( event )

   local sceneGroup = self.view

end










scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene
