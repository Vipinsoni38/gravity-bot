local composer = require( "composer" )
local scene = composer.newScene()
local widget=require "widget"
_W=display.contentWidth
_H=display.contentHeight
lode=0
local onclick=audio.loadSound("onclick.ogg")
system.setIdleTimer( false )

ads=require "ads"
bannerAppID = "ca-app-pub-9534694647722812/5949007288"
interstitialAppID="ca-app-pub-9534694647722812/4472274084"
adProvider = "admob"



function adListener( event )
   
    local msg = event.response
    -- Quick debug message regarding the response from the library
    print( "Message from the ads library: ", msg )
 
    if ( event.isError ) then
        print( "Error, no ad received", msg )
    else
        print( "Ah ha! Got one!" )
    end
end




filepathwhite=system.pathForFile("white.txt",system.DocumentsDirectory)

white=io.open(filepathwhite,"r")
if white then
else
white=io.open(filepathwhite,"w")
white:write(0)
io.close(white)
end




filepathblack=system.pathForFile("black.txt",system.DocumentsDirectory)

black=io.open(filepathblack,"r")
if black then
else
black=io.open(filepathblack,"w")
black:write(0)
io.close(black)
end

























function scene:create( event )
   local sceneGroup = self.view



--back=display.newImage("back1.png",_W/2,_H/2)
back=display.newRect(0,0,_W,_H)
back.anchorX=0
back.anchorY=.12
back.width=_W+200
back.height=_H+400
back:setFillColor(20,10,10)
sceneGroup:insert(back)
back2=display.newImage("yoyo.png",_W/2,_H/2+60)
back2.width=_W/2+130
back2.height=_H/2
sceneGroup:insert(back2)
---------------------------------------------------------------
--buttons
gameplay=widget.newButton{
    defaultFile="gameplay1.png"

}
gameplay.x=_W/2-200
gameplay.y=_H
sceneGroup:insert(gameplay)


gameplay2=widget.newButton{
    defaultFile="gameplay2.png"

}
gameplay2.x=_W/2+200
gameplay2.y=_H
sceneGroup:insert(gameplay2)
gravitybot=display.newImage("gravitybot2.png",_W/2,220)
gravitybot.width=_W
gravitybot.height=450

sceneGroup:insert(gravitybot)

how=widget.newButton{
  defaultFile="how.png",
  overFile="howover.png"
}
how.x=_W-50
how.y=350
sceneGroup:insert(how)
how.alpha=0
--how=display.newImage("how.png",_W-50,-10)

info=widget.newButton{
  defaultFile="infoover.png",
  overFile="info.png"
}
info.x=50
info.y=350
sceneGroup:insert(info)
info.alpha=0

yoyo()
check()
end
function yyi( ... )
  -- body
  lode=1
end
function check( ... )
  -- body
timer.performWithDelay(1000,yyi)
end
function yoyo()
   -- body
   vip=transition.to(gravitybot,{y=gravitybot.y+20,time=600,onComplete=gogo})

 end 
function gogo( ... )
  -- body
  piv=transition.to(gravitybot,{y=gravitybot.y-20,time=600,onComplete=yoyo})
end
function playit()
    composer.gotoScene("game")
    audio.play(onclick)
    -- body
end

local function onKeyEvent( event )
  if (event.keyName == "back") and (platformName == "Android") then
    return true
  end

  return false
end


function playitdark( ... )
  -- body
  composer.gotoScene("game2")
  audio.play(onclick)
end



function infoi( ... )
  -- body
end

function oncompleteyoo( event )
  -- body
  if event.action== "clicked" then

        local i = event.index
        print("got")
        if i==1 then
    os.exit()
  else
  end

  end
end




local function onKeyEvent( event )

    if ( event.keyName == "back" ) then


      alert=native.showAlert("Gravity Bot","do you want to exit ?",{"yes" ,"no"},oncompleteyoo)

       return true
    end
 return false
end







function scene:show( event )
    local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
    ads.init( adProvider, bannerAppID, adListener )
    ads.show( "banner", { x=0, y=10000, appId=bannerAppID } )
    composer.removeScene("game")
        composer.removeScene("game2")
        composer.removeScene("info")

gameplay:addEventListener("tap",playit)
gameplay2:addEventListener("tap",playitdark)
--info:addEventListener("tap",infoi)
--how:addEventListener("tap",howi)
Runtime:addEventListener( "key", onKeyEvent )
--Runtime:addEventListener("enterFrame",yoi)
end
end




function scene:hide( event )


local phase = event.phase

   if ( phase == "will" ) then
     

gameplay:removeEventListener("tap",playit)
gameplay2:removeEventListener("tap",playitdark)
--info:removeEventListener("tap",infoi)
--how:removeEventListener("tap",howi)
Runtime:removeEventListener( "key", onKeyEvent )
    transition.cancel(vip)
    transition.cancel(piv)




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










