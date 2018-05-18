local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
_W=display.contentWidth
_H=display.contentHeight
system.setIdleTimer( false )
local physics = require "physics"
physics.start()
gamestarted=123
myi=1
tile=10
--physics.setDrawMode("hybrid")
local onclick=audio.loadSound('onclick.ogg')
local coin=audio.loadSound('coin.ogg')
local beat=audio.loadSound('hit.ogg')
physics.setGravity(0,0)
veldir=-1
score=0
gamevalue=1
bbn=0
medelvar=0



ads=require "ads"
interstitialAppID="ca-app-pub-9534694647722812/4472274084"
bannerAppID = "ca-app-pub-9534694647722812/5949007288"
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



function moveColumns()
	if gamevalue==1 then
		for a = elements.numChildren,1,-1 do
			if(elements[a].y < hero.y) then
				if elements[a].scoreAdded == false then

					
					
					elements[a].scoreAdded = true
		score=score+1
		text.text=score
		audio.play(coin)


		if score>99 then
			miniback.isVisible=false
            miniback2.isVisible=true
        end
			end
			end
		if(elements[a].y > -180) then


				elements[a].y = elements[a].y - tile
				if myi==40 then
				
				
					--physics.setGravity(0,48)
					tile=12
				elseif myi==80 then
                    tile=14
                    --	physics.setGravity(0,48)
                end
				if  elements[a].isvip==true then
					elements[a].rotation=bbn
					bbn=bbn+4
				end
			else 
				elements:remove(elements[a])
			end	
		end
end
end







function addColumns()
	if gamevalue==1 then








	if myi%13==0 then
myi=myi+1


	topColumn = display.newImage('platblack.png',100,714)
	topColumn.anchorX = 0.5
	topColumn.anchorY = 1
	topColumn.x =  _W/2
	topColumn.y = _H+300
	topColumn.scoreAdded = false
	topColumn.isvip=true
	physics.addBody(topColumn, "static", {density=1, bounce=0, friction=0})

	elements:insert(topColumn)

elseif myi%29==0 then
width = math.random(200,280)


	topColumn = display.newImage('platgreen.png',100,714)
	topColumn.anchorX = 0.5
	topColumn.anchorY = 1
	topColumn.x =  130+width
	topColumn.y = _H+300
	topColumn.scoreAdded = false
	physics.addBody(topColumn, "static", {density=1, bounce=0, friction=0})
	elements:insert(topColumn)
	topColumn.isvip=false
	
	bottomColumn = display.newImage('platgreen2.png',100,714)
	bottomColumn.anchorX = 0.5
	bottomColumn.anchorY = 1
	bottomColumn.x =topColumn.x
	bottomColumn.y =topColumn.y- bottomColumn.height
	physics.addBody(bottomColumn, "static", {density=1, bounce=0, friction=0})
	bottomColumn:addEventListener("collision",gameover)
	elements:insert(bottomColumn)
	myi=myi+1
else
		width = math.random(20,480)

	if myi>80 then
				topColumn = display.newImage('platbrown.png',100,714)
elseif myi>40 then
		topColumn = display.newImage('platyellow.png',100,714)
	else
		topColumn = display.newImage('plat.png',100,714)
	end
	topColumn.anchorX = 0.5
	topColumn.anchorY = 1
	topColumn.x =  -300+width
	topColumn.y = _H+300
	topColumn.scoreAdded = false
	physics.addBody(topColumn, "static", {density=1, bounce=0, friction=0})
	elements:insert(topColumn)
	topColumn.isvip=false
	
	if myi>80 then
				bottomColumn = display.newImage('platbrown.png',100,714)

	elseif myi>40 then
		bottomColumn = display.newImage('platyellow.png',100,714)
	else
		bottomColumn = display.newImage('plat.png',100,714)
	end
	bottomColumn.anchorX = 0.5
	bottomColumn.anchorY = 1
	bottomColumn.x = _H/2+100+width
	bottomColumn.y =_H+300
	physics.addBody(bottomColumn, "static", {density=1, bounce=0, friction=0})
	elements:insert(bottomColumn)
	myi=myi+1
end
end	
end









function scene:create( event )

ads.hide( "banner", { x=0, y=10000, appId=bannerAppID } )
   local sceneGroup = self.view

cloud=display.newImage("clouds1.png")

cloud.x=350
cloud.y=500
cloud.height=_H+400
cloud.width=_W
sceneGroup:insert(cloud)


cloud2=display.newImage("clouds1.png")

cloud2.x=350
cloud2.y=500+_H+400
cloud2.height=_H+400
cloud2.width=_W
sceneGroup:insert(cloud2)




text=display.newText("0",_W/2,130,system.defaultFont,72)
sceneGroup:insert(text)


spikes=display.newImage("spikes.png",380,0)
spikes.width=_W
spikes.y=-150
physics.addBody(spikes,"static",{bounce=0,friction=.5})
sceneGroup:insert(spikes)

leftWall=display.newRect(-290,0,10,_H+290)
physics.addBody(leftWall,"static",{bounce=0,friction=0})
leftWall.x=0
leftWall.y=500
leftWall.alpha=0
sceneGroup:insert(leftWall)
rightWall=display.newRect(-290,_W,10,_H+290)
physics.addBody(rightWall,"static",{bounce=0,friction=0})
rightWall.x=_W
rightWall.y=500
rightWall.alpha=0
sceneGroup:insert(rightWall)
p_options = 
	{
		-- Required params
		width = 70,
		height = 115,
		numFrames = 2,
		-- content scaling
		sheetContentWidth = 140,
		sheetContentHeight = 115,
	}
	playerSheet = graphics.newImageSheet( "hero1.png", p_options )

	hero = display.newSprite( playerSheet, { name="player", start=1, count=2, time=400 } )
	
	hero.x = _W/2
	hero.y = 980
	hero:play()


--hero=display.newImage("hero.png")
--hero.x=70
--hero.y=0
physics.addBody(hero,"dynamic",{bounce=0,friction=0})
		--native.showAlert("Developer's message", "hiiiiiiiii        its vipin", { "ok" })
sceneGroup:insert(hero)


flag=display.newImage("flag.png",3090,100)
physics.addBody(flag,"static")
--flag.isSensor=true
flag.isVisible=false
flag.isSensor=true

sceneGroup:insert(flag)


















    elements = display.newGroup()
	elements.anchorChildren = true
	elements.anchorX = 0
	elements.anchorY = 1
	elements.x = 0
	elements.y = 0
	sceneGroup:insert(elements)


miniback=display.newImage("miniback.png")
miniback.x=text.x
miniback.y=text.y
sceneGroup:insert(miniback)
miniback2=display.newImage("miniback2.png")
miniback2.x=text.x
miniback2.y=text.y
miniback2.isVisible=false
sceneGroup:insert(miniback2)



text.alpha=0
miniback.alpha=0

scoreboard=display.newImage("scoreboard.png")
scoreboard.x=text.x
scoreboard.y=text.y-600
scoreboard.alpha=0
scoreboard.height=scoreboard.height+100
sceneGroup:insert(scoreboard)
home=display.newImage("home.png")
home.x=80
home.y=text.y
home.alpha=false
sceneGroup:insert(home)
home.height=home.height*2.6/3





--buttons
gameplay1=widget.newButton{
    defaultFile="gameplay2.png",

}
gameplay1.x=_W/2
gameplay1.y=_H
sceneGroup:insert(gameplay1)

gameplay1.alpha=0







right=display.newImage("right.png")
right.alpha=0
sceneGroup:insert(right)
left=display.newImage("left.png")
left.alpha=0
sceneGroup:insert(left)





text2=display.newText("0",_W*2.2/3,330,system.defaultFont,40)
text2:setFillColor(0,0,0)
sceneGroup:insert(text2)
text3=display.newText("0",_W*2.2/3,450,system.defaultFont,40)
text3.alpha=0
text2.alpha=0
text3:setFillColor(0,0,0)
sceneGroup:insert(text3)


medel0=display.newImage("medel0.png",175,420)
medel1=display.newImage("medel1.png",175,420)
medel2=display.newImage("medel2.png",175,420)
medel3=display.newImage("medel3.png",175,420)
medel4=display.newImage("medel4.png",175,420)

medel4.alpha=0
medel3.alpha=0
medel2.alpha=0
medel1.alpha=0
medel0.alpha=0
sceneGroup:insert(medel4)
sceneGroup:insert(medel3)
sceneGroup:insert(medel2)
sceneGroup:insert(medel1)
sceneGroup:insert(medel0)
temp=display.newImage("temp.png",_W/2,_H-200)
sceneGroup:insert(temp)

---gameover()

end









function action(self,event)
	-- body

--	hero:setLinearVelocity(200,0)
	hero:applyForce(20,0,hero.x,hero.y)
end


function action2( ... )

	--hero:setLinearVelocity(-200,0)
	hero:applyForce(-20,0,hero.x,hero.y)
	-- body
end


 function onKeyEvent( event )
  if (event.keyName == "back") and (platformName == "Android") then
    return true
  end

  return false
end


function action3( ... )
	if gamestarted==123 then
gamestarted=true
addColumnTimer = timer.performWithDelay(1300, addColumns, -1)
moveColumnTimer = timer.performWithDelay(2, moveColumns, -1)
			
--timer.performWithDelay(1400,hoo)
text.alpha=1
miniback.alpha=1
right.alpha=0
temp.alpha=0
	elseif gamestarted==234 then
	a=350
	if gamevalue==1 then
if veldir>0 then
	--hero:setLinearVelocity(-200,0)
	hero:setLinearVelocity(-a,0)
	left.alpha=0
	right.alpha=1
	-- body
	veldir=-1
	elseif veldir<0 then

			hero:setLinearVelocity(a,0)
			veldir=1
				left.alpha=1
	right.alpha=0
end
end
end
end
function oncollision( event )
	-- body
	if event.phase == "began"  then
	--composer:gotoScene("selectlevel")
end
end

function ending( )
	-- body
	print("end")
end
function hooi( ... )
	-- body


filepathwhite=system.pathForFile("white.txt",system.DocumentsDirectory)

white=io.open(filepathwhite,"r")
if white then
str=white:read()
io.close(white)
return str
end


end
function change( ... )
	-- body
	str=tostring(score)
	str="*"..str
	text3.text=str
end

function check( ... )
	-- body


filepathwhite=system.pathForFile("white.txt",system.DocumentsDirectory)

num=tonumber(str)
print(num)
print(score)
if num<score then
	print("0")
white=io.open(filepathwhite,"w")
if white then
white:write(score)
io.close(white)
timer.performWithDelay(1200,change)





end
end


print("xjg")
if score<15 then
	medel0.alpha=1
		elseif score>=15 and score<30 then

			medel1.alpha=1
			elseif score>=30 and score<50 then
	
				medel2.alpha=1
				elseif score>=50 and score<80 then
			
					medel3.alpha=1
					elseif score>=80 then
			
						medel4.alpha=1
						end


end





function gameover( ... )
	-- body
 ads.show( "banner", { x=0, y=10000, appId=bannerAppID } )
audio.play(beat)
		jjh=hooi()
		check()
    scoreboard.y=100
	transition.to(scoreboard,{time=300,alpha=1, y=400})
	text.isVisible=false
	physics.setGravity(0,0)
	gamevalue=0
	miniback.isVisible=false
	miniback2.isVisible=false
	hero.isVisible=false
	hero:removeSelf()
	transition.to(home,{time=700,alpha=1})
		transition.to(gameplay1,{time=700,alpha=1,y=_H/2+300})
		left.alpha=0
		right.alpha=0
		bbj=tostring(score)
		
		text2.text=bbj
		text3.text=jjh
		text3.alpha=1
text2.alpha=1

if ( ads.isLoaded("interstitial") ) then
    ads.show("interstitial")
end
 





end
function scrolli( ... )
	-- body
if gamevalue==1 then
	right.x=hero.x
	right.y=hero.y


	left.x=hero.x
	left.y=hero.y
if cloud.y>-400-_H then
	cloud.y=cloud.y-2
	else 
		cloud.y=500+_H+400
	end

if cloud2.y>-400-_H then
	cloud2.y=cloud2.y-2
	else 
		cloud2.y=500+_H+400
	end



	if hero.rotation<0 or hero.rotation>0 then
		hero.rotation=0
	end

	if hero.y>_H+200 then
		if gamevalue==1 then
		gameover()
		gamevalue=0
	end
end
end

end




function restart( ... )
	-- body

	composer.gotoScene("restart1","fade",300)
audio.play(onclick)
end







function gohome( ... )
	-- body

	composer.gotoScene("start")
	audio.play(onclick)
end

function accelerometercall(e)
	-- body
		if hero then
		if gamevalue==1 then
			if gamestarted==true then
	px,py=hero:getLinearVelocity()
	if py<0 or py>0 then
		py=0
	--	print("okvip")
	end
	hero:setLinearVelocity(e.xGravity*5000,py)
end
end
end
end




local function onKeyEvent( event )

    if ( event.keyName == "back" ) then
    	composer.gotoScene("start")
       return true
    end
 return false
end



function scene:show( event )
local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
	composer.removeScene("start")
	ads.load( "interstitial", { appId=interstitialAppID } )
	    ads.init( adProvider, interstitialAppID, adListener )
   
	        ads.init( adProvider, bannerAppID, adListener )
	--composer.removeScene("restart")
--righttouch:addEventListener("tap",action)
--lefttouch:addEventListener("tap",action2)
Runtime:addEventListener("accelerometer",accelerometercall)
Runtime:addEventListener("tap",action3)
flag:addEventListener("collision",oncollision)
spikes:addEventListener("collision",gameover)
Runtime:addEventListener("enterFrame",scrolli)
home:addEventListener("tap",gohome)
gameplay1:addEventListener("tap",restart)
right.alpha=0
left.alpha=0
Runtime:addEventListener( "key", onKeyEvent )
end

end




















function scene:hide( event )

local phase = event.phase

   if ( phase == "will" ) then
     


Runtime:removeEventListener("tap",action3)
Runtime:removeEventListener("accelerometer",accelerometercall)
flag:removeEventListener("collision",oncollision)
spikes:removeEventListener("collision",gameover)
Runtime:removeEventListener("enterFrame",scrolli)
home:removeEventListener("tap",gohome)
	timer.cancel(addColumnTimer)
	timer.cancel(moveColumnTimer)

gameplay1:removeEventListener("tap",restart)
Runtime:removeEventListener( "key", onKeyEvent )



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
