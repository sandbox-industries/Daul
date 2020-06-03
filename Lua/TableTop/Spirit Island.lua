

AidTokenZones = {
    ["Blue"] = "50c3f2",
    ["Yellow"] = "7f50b8",
    ["Purple"] = "be99d1",
    ["Red"] = "a3e7da",
    ["Green"] = "a87bd4",
    ["Orange"] = "15fdb4",
}
PresenceTokenZones = {
    ["Blue"] = "0baa2b",
    ["Yellow"] = "1cb91b",
    ["Purple"] = "cd4464",
    ["Red"] = "f48a30",
    ["Green"] = "558842",
    ["Orange"] = "c05bfe",
}



fearMax = 4
fearCurrent = 0
quoteColor = {0.9,0.9,0.9}

function onSave()
	if fearMax == nil then fearMax = 4 end
	if fearCurrent == nil then fearCurrent = 0 end
	if gameStarted == nil then gameStarted = 0 end
	if difficultyString == nil then difficultyString = "" end
	data_table = {
		fearMax = fearMax,
		fearCurrent = fearCurrent,
		gameStarted = gameStarted,
		difficultyString = difficultyString,
		adversaryName = adversaryName,
		adversaryLevel = adversaryLevel,
	}
    saved_data = JSON.encode(data_table)
--	if gameStarted > 0 then
--		for i,v in ipairs(getObjectFromGUID("bd8761").getObjects()) do
--			if v.getPosition().y <= 1.8 and (v.tag == "Card" or v.tag == "Deck") and math.floor(v.getPosition().x) == -41 and math.floor(v.getPosition().z) == 11 then
--				v.setLock(true)
--			end
--		end
--		startLuaCoroutine(Global, "unlockDelay")
--	end
	return saved_data
end
function unlockDelay()
	wt(0.1)
	for i,v in ipairs(getObjectFromGUID("bd8761").getObjects()) do
		v.setLock(false)
	end
	return 1
end

loaded_data = ""

-- card grid 		lines 4.42,4.3 offset 0,2
-- element tokens	lines 2.16,4.3 offset various, 3

aidBoard = "bee103"
SetupChecker = "ab0a4e"
PowerChecker = "ef7e87"
TurnChecker = "212e40"
------
elementScanZones = {
    "9fc5a4",
    "654ab2",
    "102771",
    "6f2249",
    "190f05",
    "61ac7c",
}
spirits = {
	"4c85c9",
	"b06297",
	"e4b9fc",
	"737493",
	"a26ef0",
	"3a47aa",
	"c9e1e7",
	"083af1",
	"fc30ca",
	"eba9c5",
	"aa9677",
	"2f2173",
}
------
dahanBag = "f4c173"
explorerBag = "613ea4"
townBag = "4d3c15"
cityBag = "a245f8"
blightBag = "af50b8"
blightBagInfinite = "3595ff"
beastsBag = "bdfb9c"
diseaseBag = "0e6f8b"
wildsBag = "ec209b"
strifeBag = "6c458a"
isolateBag = "3a78b8"
counterBag = "5f2acb"
-----
FearDeck = "01795f"
Terror2 = "2b7d0b"
Terror3 = "4211e9"
----
FearTokens1 = "934fd9"
FearTokens2 = "683776"
FearTokens3 = "72ebd9"
-----
StandardMapBag = "983317"
ThematicMapBag = "f3889e"
-----
gameStart = false
seaTile = "5f4be2"
-----
cityHealth = "22928c"
cityDamage = "d8b6c7"
townHealth = "4e6aee"
townDamage = "7f1e11"
explorerHealth = "87ee9c"
explorerDamage = "574835"
dahanHealth = "746488"
dahanDamage = "d936f3"
-----
blightCardMultipliers = {
	["49b2d1"] = 5,
	["994821"] = 4,
	["155cbe"] = 3,
	["ea2208"] = 5,
	["06d2c2"] = 2,
	["c579fe"] = 5,
	["d4e20c"] = 4,
	["a232a7"] = 3,
	["140352"] = 2,
}

interactableObjectsToDisableOnStart = {
	--dahanBag,
	--explorerBag,
	--townBag,
	--cityBag,
	--blightBag,
	"16ab25","eb5ab2","be2c91","f4a568", -- adversary tiles
	--"e5d18b", --england extra build board
}

interactableObjectsToDisableOnLoad = {
	"a2b8a6","f01594","712847","27f6da","f8cf71","4728bd", -- table elements
	"5f4be2", -- sea tile
	"ab0a4e", -- start menu object
	"6b5b4b","fac8e4","36bbcc","c3c59b","661aa3","c68e2c", -- element object
	"ef7e87", -- learn power object
	--"bee103", --Game aidBoard
	"14fd68", -- difficulty object
	"4aad34", -- reset Cube
}

function numToBin(x)
	ret=""
	while x~=1 and x~=0 do
		ret=tostring(x%2)..ret
		x=math.modf(x/2)
	end
	ret=tostring(x)..ret
	return ret
end

function onLoad(saved_data)
	aidBoard = getObjectFromGUID(aidBoard)
	for i,v in ipairs(interactableObjectsToDisableOnLoad) do
		if getObjectFromGUID(v) != nil then
			getObjectFromGUID(v).setLock(true)
			getObjectFromGUID(v).interactable = false
		end
	end


	resetCube = getObjectFromGUID("4aad34")
	resetCube.createButton({
        click_function = "reset",
        function_owner = Global,
        label          = "",
        position       = {0,0.8,0},
        width          = 200,
        height         = 200,
	})
	------
	expansionsAdded = false
    player1 = false
    player2 = false
    player3 = false
    player4 = false
    SetupChecker = getObjectFromGUID(SetupChecker)
    PowerChecker = getObjectFromGUID(PowerChecker)
    TurnChecker = getObjectFromGUID(TurnChecker)
    ------
    dahanBag = getObjectFromGUID(dahanBag)
    explorerBag = getObjectFromGUID(explorerBag)
    townBag = getObjectFromGUID(townBag)
    cityBag = getObjectFromGUID(cityBag)
    blightBag = getObjectFromGUID(blightBag)
	blightBagInfinite = getObjectFromGUID(blightBagInfinite)
	diseaseBag = getObjectFromGUID(diseaseBag)
	wildsBag = getObjectFromGUID(wildsBag)
	beastsBag = getObjectFromGUID(beastsBag)
	strifeBag = getObjectFromGUID(strifeBag)
	isolateBag = getObjectFromGUID(isolateBag)
    -----
    cityHealth = getObjectFromGUID(cityHealth)
    cityDamage = getObjectFromGUID(cityDamage)
    townHealth = getObjectFromGUID(townHealth)
    townDamage = getObjectFromGUID(townDamage)
    explorerHealth = getObjectFromGUID(explorerHealth)
    explorerDamage = getObjectFromGUID(explorerDamage)
    dahanHealth = getObjectFromGUID(dahanHealth)
    dahanDamage = getObjectFromGUID(dahanDamage)
    -----
    FearDeck = getObjectFromGUID(FearDeck)
    Terror2 = getObjectFromGUID(Terror2)
    Terror3 = getObjectFromGUID(Terror3)
    -----
	fearCards1 = 3
	fearCards2 = 3
	fearCards3 = 3
	-----
    StandardMapBag = getObjectFromGUID(StandardMapBag)
    StandardMapBag.shuffle()
    ThematicMapBag = getObjectFromGUID(ThematicMapBag)
	seaTile = getObjectFromGUID(seaTile)
    -- Loads the tracking for if the game has started yet
    if saved_data ~= "" then
		loaded_data = JSON.decode(saved_data)
		gameStarted = loaded_data.gameStarted
		--print ("loaded gameStarted = "..loaded_data.gameStarted)`
		--print ("loaded fearMax = "..loaded_data.fearMax)
		--print ("loaded fearCurrent = "..loaded_data.fearCurrent)
		--print ("loaded difficultyString = "..loaded_data.difficultyString)
		startLuaCoroutine(Global,"setFear")
		spiritPower()
		addBlightedIslandButton()
		if gameStarted > 0 then
			getObjectFromGUID("14fd68").createButton({ -- add difficulty text
				click_function = "nullFunc",
				function_owner = Global,
				label          = Global.getTable("loaded_data").difficultyString,
				position       = {0,1.4,0},
				rotation       = {0,180,0},
				font_size      = 500,
				font_color     = {1,1,1},
			})
			gameStart = true
			if Global.getTable("loaded_data").adversaryName == "England" and Global.getTable("loaded_data").adversaryLevel >= 5 then
				newTownBag = getObjectFromGUID("942899")
				newCityBag = getObjectFromGUID("cb7231")
			end
			startLuaCoroutine(Global,"zoneDestroyTimerCoro")
		else
		    SetupChecker.createButton({
		        click_function = "player4Setup",
		        function_owner = Global,
		        label          = "4 player",
		        position       = {0,0.3,-4.5},
		        width          = 1800,
		        height         = 600,
		        font_size      = 300,
		    })
		    SetupChecker.createButton({
		        click_function = "player3Setup",
		        function_owner = Global,
		        label          = "3 player",
		        position       = {0,0.3,-3},
		        width          = 1800,
		        height         = 600,
		        font_size      = 300,
		    })
		    SetupChecker.createButton({
		        click_function = "player2Setup",
		        function_owner = Global,
		        label          = "2 player",
		        position       = {0,0.3,-1.5},
		        width          = 1800,
		        height         = 600,
		        font_size      = 300,
		    })
		    SetupChecker.createButton({
		        click_function = "player1Setup",
		        function_owner = Global,
		        label          = "1 player",
		        position       = {0,0.3,0},
		        width          = 1800,
		        height         = 600,
		        font_size      = 300,
		    })
		    SetupChecker.createButton({
		        click_function = "SetupGame",
		        function_owner = Global,
		        label          = "Setup Game",
		        position       = {0,0.3,12},
		        width          = 1800,
		        height         = 600,
		        font_size      = 300,
		    })

			SetupChecker.createButton({
				click_function = "nullFunc",
				function_owner = Global,
				label          = "Adversary",
				font_color	   = {1,1,1},
				position       = {0,0.3,2},
				width          = 0,
				height         = 0,
				font_size      = 300,
			})
			SetupChecker.createButton({
				click_function = "adversaryButton",
				function_owner = Global,
				label          = "None",
				position       = {0,0.3,3},
				width          = 1800,
				height         = 600,
				font_size      = 200,
			})
			SetupChecker.createButton({
				click_function = "nullFunc",
				function_owner = Global,
				label          = "Adversary Level",
				font_color	   = {1,1,1},
				position       = {0,0.3,4.5},
				width          = 0,
				height         = 0,
				font_size      = 300,
			})
			SetupChecker.createButton({
				click_function = "levelButton",
				function_owner = Global,
				label          = "N/A",
				position       = {0,0.3,5.5},
				width          = 1800,
				height         = 600,
				font_size      = 300,
			})
			SetupChecker.createButton({
				click_function = "nullFunc",
				function_owner = Global,
				label          = "Difficulty: 0",
				font_color	   = {1,1,1},
				position       = {0,0.3,7.0},
				width          = 0,
				height         = 0,
				font_size      = 300,
			})

		    SetupChecker.createButton({
		        click_function = "boardTypeF",
		        function_owner = Global,
		        label          = "Standard Map",
		        position       = {0,0.3,10},
		        width          = 2000,
		        height         = 600,
		        font_size      = 300,
		    })

		    SetupChecker.createButton({
		        click_function = "addExpansionCards",
		        function_owner = Global,
		        label          = "ADD EXPANSIONS",
		        position       = {0,0.3,-6},
		        width          = 1800,
		        height         = 450,
		        font_size      = 200,
		    })

		end
    end
    if Player["White"].seated == true then Player["White"].changeColor("Red") end
end

boardType = "Standard"
function boardTypeF()
	currentBoardType = SetupChecker.getButtons()[11].label
	if currentBoardType == "Standard Map" then
		boardType = "Thematic"
		SetupChecker.editButton({
			index          = 10,
			label          = "Thematic Map",
		})
	else
		boardType = "Standard"
		SetupChecker.editButton({
			index          = 10,
			label          = "Standard Map",
		})
	end
	updateDifficulty()
end

function reset(objClicked, playerColorClicked)
	if Player[playerColorClicked].steam_name == "Bone White" then
		print ("reset")
		gameStarted = 0
		fearMax = 4
		fearCurrent = 0
		difficultyString = ""
	end
end

function setFear()
	wt(0.5)
	aidBoard.editButton({index = 0, label = Global.getTable("loaded_data").fearMax - Global.getTable("loaded_data").fearCurrent})
	aidBoard.editButton({index = 1, label = Global.getTable("loaded_data").fearCurrent})
	return 1
end


function nullFunc()
end
adversaryNames = {
	"None",
	"Brandenburg-Prussia",
	"England",
	"France",
	"Sweden",
}
adversaryName = "None"
adversaryLevel = 0

function adversaryButton()
	adversaryIndex = 1
	for i = 1, #adversaryNames do
		if adversaryNames[i] == adversaryName then
			adversaryIndex = i
		end
	end
	if adversaryIndex == #adversaryNames then adversaryIndex = 1 else adversaryIndex = adversaryIndex + 1 end
	SetupChecker.editButton({
		index          = 6,
		label          = adversaryNames[adversaryIndex],
	})
	adversaryName = adversaryNames[adversaryIndex]
	if adversaryIndex == 1 then
		adversaryLevel = 0
		SetupChecker.editButton({
			index          = 8,
			label          = "N/A",
		})
    else
		adversaryLevel = 0
		SetupChecker.editButton({
			index          = 8,
			label          = "0",
		})
	end
	updateDifficulty()
end
function levelButton()
	currentLevel = tonumber(SetupChecker.getButtons()[9].label)
	adversaryName = SetupChecker.getButtons()[7].label
	newLevel = 0
	if adversaryName == "None" then
		broadcastToAll("Select an adversary before setting a level", {0.95,0,0})
		return
	end
	if currentLevel == 6 then
		newLevel = 0
	else
		newLevel = currentLevel + 1
	end
	SetupChecker.editButton({
		index          = 8,
		label          = newLevel,
	})
	adversaryLevel = newLevel
	updateDifficulty()
end
difficulty = 0
function updateDifficulty()
	difficulty = 0
	if adversaryName == "Brandenburg-Prussia" then
		if adversaryLevel == 0 then
			difficulty = 1
		elseif adversaryLevel == 1 then
			difficulty = 2
		elseif adversaryLevel == 2 then
			difficulty = 4
		elseif adversaryLevel == 3 then
			difficulty = 6
		elseif adversaryLevel == 4 then
			difficulty = 7
		elseif adversaryLevel == 5 then
			difficulty = 9
		elseif adversaryLevel == 6 then
			difficulty = 10
		end
	elseif adversaryName == "England" then
		if adversaryLevel == 0 then
			difficulty = 1
		elseif adversaryLevel == 1 then
			difficulty = 3
		elseif adversaryLevel == 2 then
			difficulty = 4
		elseif adversaryLevel == 3 then
			difficulty = 6
		elseif adversaryLevel == 4 then
			difficulty = 7
		elseif adversaryLevel == 5 then
			difficulty = 9
		elseif adversaryLevel == 6 then
			difficulty = 10
		end
	elseif adversaryName == "France" then
		if adversaryLevel == 0 then
			difficulty = 1
		elseif adversaryLevel == 1 then
			difficulty = 3
		elseif adversaryLevel == 2 then
			difficulty = 5
		elseif adversaryLevel == 3 then
			difficulty = 7
		elseif adversaryLevel == 4 then
			difficulty = 8
		elseif adversaryLevel == 5 then
			difficulty = 9
		elseif adversaryLevel == 6 then
			difficulty = 10
		end
	elseif adversaryName == "Sweden" then
		if adversaryLevel == 0 then
			difficulty = 1
		elseif adversaryLevel == 1 then
			difficulty = 2
		elseif adversaryLevel == 2 then
			difficulty = 3
		elseif adversaryLevel == 3 then
			difficulty = 5
		elseif adversaryLevel == 4 then
			difficulty = 6
		elseif adversaryLevel == 5 then
			difficulty = 7
		elseif adversaryLevel == 6 then
			difficulty = 8
		end
	end
	if SetupChecker.getButtons()[10].label == "Thematic" then difficulty = difficulty + 3 end
	SetupChecker.editButton({
		index          = 9,
		label          = "Difficulty: "..difficulty,
	})
end

canStart = true
function addExpansionCards()
	SetupChecker.removeButton(#SetupChecker.getButtons()-1)
    canStart = false
	expansionsAdded = true
    startLuaCoroutine(Global, "addExpansionCardsCo")
end
function addExpansionCardsCo()
	expansionFearDeck = getObjectFromGUID("dd45d1")
	expansionEventDeck = getObjectFromGUID("ab6881")
	expansionMinorDeck = getObjectFromGUID("6fde08")
	expansionMajorDeck = getObjectFromGUID("b40bfa")
	expansionHealthyDeck = getObjectFromGUID("9373f2")
	expansionTextField = getObjectFromGUID("eedc94")

	blightBag.setPositionSmooth(vecSum(blightBag.getPosition(),{0,10,0}))

	getObjectFromGUID("01795f").putObject(expansionFearDeck)
	expansionEventDeck.setPositionSmooth({-47.24, 1.4, 14.77})
    getObjectFromGUID("089896").getObjects()[1].putObject(expansionMajorDeck)
	getObjectFromGUID("cb16ab").getObjects()[1].putObject(expansionMinorDeck)
	getObjectFromGUID("b0b6d8").getObjects()[1].putObject(expansionHealthyDeck)
	wt(1)
	blightBag.setPosition(vecSum(blightBag.getPosition(),{0,10,0}))
	expansionTextField.destruct()
    canStart = true
	return(1)
end
invaderIndex = 1
invaderTitles = {
	"Default",
	"Brandenburg-Prussia 2",
	"Brandenburg-Prussia 3",
	"Brandenburg-Prussia 4",
	"Brandenburg-Prussia 5",
	"Brandenburg-Prussia 6",
}
invaderOrderText = {
	"111-2222-33333",
	"111-3-2222-3333",
	"11-3-2222-3333",
	"11-3-222-3333",
	"1-3-222-3333",
	"3-222-3333",
}
function invaderDeckButton()
	if invaderIndex == #invaderTitles then
		invaderIndex = 1
	else
		invaderIndex = invaderIndex + 1
	end
	SetupChecker.editButton({
		index          = 10,
		label          = invaderTitles[invaderIndex],
	})
	SetupChecker.editButton({
		index          = 11,
		label          = invaderOrderText[invaderIndex],
	})

end
function fearCardsButton1()
	if tonumber(fearCards1) == 5 then
		fearCards1 = 3
	    SetupChecker.editButton({
	        index          = 6,
	        label          = "3",
	    })
	else
		fearCards1 = tonumber(fearCards1) + 1
	    SetupChecker.editButton({
	        index          = 6,
	        label          = tostring(fearCards1),
	    })
	end
end
function fearCardsButton2()
	if tonumber(fearCards2) == 5 then
		fearCards2 = 3
	    SetupChecker.editButton({
	        index          = 7,
	        label          = "3",
	    })
	else
		fearCards2 = tonumber(fearCards2) + 1
	    SetupChecker.editButton({
	        index          = 7,
	        label          = tostring(fearCards2),
	    })
	end
end
function fearCardsButton3()
	if tonumber(fearCards3) == 5 then
		fearCards3 = 3
	    SetupChecker.editButton({
	        index          = 8,
	        label          = "3",
	    })
	else
		fearCards3 = tonumber(fearCards3) + 1
	    SetupChecker.editButton({
	        index          = 8,
	        label          = tostring(fearCards3),
	    })
	end
end

function player4Setup()
    player4 = true
    player3 = false
    player2 = false
    player1 = false
    SetupChecker.editButton({
        index          = 0,
        label          = ">4 player<",
    })
    SetupChecker.editButton({
        index          = 1,
        label          = "3 player",
    })
    SetupChecker.editButton({
        index          = 2,
        label          = "2 player",
    })
    SetupChecker.editButton({
        index          = 3,
        label          = "1 player",
    })
end
function player3Setup()
    player3 = true
    player4 = false
    player2 = false
    player1 = false
    SetupChecker.editButton({
        index          = 0,
        label          = "4 player",
    })
    SetupChecker.editButton({
        index          = 1,
        label          = ">3 player<",
    })
    SetupChecker.editButton({
        index          = 2,
        label          = "2 player",
    })
    SetupChecker.editButton({
        index          = 3,
        label          = "1 player",
    })
end
function player2Setup()
    player2 = true
    player4 = false
    player3 = false
    player1 = false
    SetupChecker.editButton({
        index          = 0,
        label          = "4 player",
    })
    SetupChecker.editButton({
        index          = 1,
        label          = "3 player",
    })
    SetupChecker.editButton({
        index          = 2,
        label          = ">2 player<",
    })
    SetupChecker.editButton({
        index          = 3,
        label          = "1 player",
    })
end
function player1Setup()
    player1 = true
    player2 = false
    player4 = false
    player3 = false
    SetupChecker.editButton({
        index          = 0,
        label          = "4 player",
    })
    SetupChecker.editButton({
        index          = 1,
        label          = "3 player",
    })
    SetupChecker.editButton({
        index          = 2,
        label          = "2 player",
    })
    SetupChecker.editButton({
        index          = 3,
        label          = ">1 player<",
    })
end
-----
function spiritPower()
    PowerChecker.createButton({
        click_function = "MajorPowerC",
        function_owner = Global,
        label          = "Major",
        position       = {0,0.8, -2.2},
        width          = 2000,
        height         = 1600,
        font_size      = 700,
		tooltip        = "Click to learn a Major Power",
    })
    PowerChecker.createButton({
        click_function = "MinorPowerC",
        function_owner = Global,
        label          = "Minor",
		position	   = {0, 0.8, 2.2},
        width          = 2000,
        height         = 1600,
        font_size      = 700,
		tooltip        = "Click to learn a Minor Power",
    })
    return 1
end
-----
majorPowerAlt = nil
majorPowerCol = nil
function MajorPowerC(obj, player_color, alt_click)
	--if gameStarted == 0 or gameStarted == nil then return end
	majorPowerCol = player_color
	majorPowerAlt = alt_click
    startLuaCoroutine(Global, "MajorPower")
end
minorPowerAlt = nil
minorPowerCol = nil
function MinorPowerC(obj, player_color, alt_click)
	--if gameStarted == 0 or gameStarted == nil then return end
	minorPowerCol = player_color
	minorPowerAlt = alt_click
    startLuaCoroutine(Global, "MinorPower")
end
posMajor = {
    {-32.81, 1.03, -7.91},
    {-29.24, 1.03, -7.91},
    {-25.71, 1.03, -7.91},
    {-22.13, 1.03, -7.91}
}
posMinor = {
    {-32.81, 1.03, -3.42},
    {-29.24, 1.03, -3.42},
    {-25.71, 1.03, -3.42},
    {-22.13, 1.03, -3.42}
}
function getPowerZoneObjects(handP)
	local hits = upCastPosSizRot(
		vecSum({handP.x,yHeight,handP.z},handOffset), -- pos
		{15,1,4},  -- size
		{0,0,0},  --  rotation
		1,  -- distance
		1,  -- multi
		{"Card","Deck"})
	return hits
end
handOffset = {0,0,35}
yHeight = 0
function MinorPower()
	local player_color = minorPowerCol
	local altClicked = minorPowerAlt
	yHeight = seaTile.getPosition().y + 0.1
	MinorPowerDiscardZone = getObjectFromGUID("55b275")
	MinorPowerDiscardZonePos = MinorPowerDiscardZone.getPosition()
	MinorPoweZone = getObjectFromGUID("cb16ab")
	MinorPoweDeck = MinorPoweZone.getObjects()
    if scriptWorkingCardC == 0 then
        scriptWorkingCardC = 1
	-- clear the zone!
	local handPos = Player[player_color].getHandTransform().position
	local powerDealCentre = vecSum({handPos.x,yHeight,handPos.z},handOffset)
	local xPadding = 4.4
	local hits = getPowerZoneObjects(handPos)
    for o, obj in pairs(hits) do
        obj.setLock(false)
        obj.setPositionSmooth({MinorPowerDiscardZonePos.x, MinorPowerDiscardZonePos.y+o/10, MinorPowerDiscardZonePos.z})
        obj.setRotationSmooth({0.00, 180.00, 0.00})
		obj.clearButtons()
		wt(0.2)
    end
    wt(0.5)
    scriptWorkingCardC = 0
	local cardPlaceOffsetXs = {
		-(2.5*xPadding)+1*xPadding,
		-(2.5*xPadding)+2*xPadding,
		-(2.5*xPadding)+3*xPadding,
		-(2.5*xPadding)+4*xPadding,
	}
	log(MinorPoweDeck[1])
    if MinorPoweDeck[1] == nil then
        wt(1)
		MinorPoweDeck = MinorPowerDiscardZone.getObjects()
        MinorPoweDeck[1].setPositionSmooth({MinorPoweZone.getPosition().x, MinorPoweZone.getPosition().y, MinorPoweZone.getPosition().z})
		MinorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
        MinorPoweDeck[1].shuffle()
        wt(1)
        for z=1, 4 do
			local tempMinorCard = MinorPoweDeck[1].takeObject({
				position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                flip           = true
            })
            tempMinorCard.createButton({
                click_function = "PickPowerMinor",
                function_owner = Global,
                label          = "Pick Power",
                position       = {0,0.3,1.47},
                width          = 1000,
                scale          = {0.9,1,0.5},
                --height         = 340,
                font_size      = 180,
                color          = {71/255,48/255,32/255,0.6},
                font_color     = {1,1,1},
                tooltip = "Pick Power Card to your hand"
            })
			tempMinorCard.setLock(true)
			wt(0.2)
        end
    elseif MinorPoweDeck[1].tag == "Card" then
            MinorPoweDeck[1].setPositionSmooth(vecSum(powerDealCentre,{cardPlaceOffsetXs[1],0,0}))
            MinorPoweDeck[1].setRotationSmooth({0.00, 180.00, 0.00})
            MinorPoweDeck[1].createButton({
                click_function = "PickPowerMinor",
                function_owner = Global,
                label          = "Pick Power",
                position       = {0,0.3,1.47},
                width          = 1000,
                scale 		   = {0.9,1,0.5},
                --height         = 340,
                font_size      = 180,
                color          = {71/255,48/255,32/255,0.6},
                font_color     = {1,1,1},
                tooltip = "Pick Power Card to your hand"
            })
			MinorPoweDeck[1].setLock(true)
            wt(1.5)
            MinorPoweDeck = getObjectFromGUID("55b275").getObjects()
			MinorPoweZone = getObjectFromGUID("cb16ab")
	        MinorPoweDeck[1].setPositionSmooth({MinorPoweZone.getPosition().x, MinorPoweZone.getPosition().y, MinorPoweZone.getPosition().z})
			MinorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
	        MinorPoweDeck[1].shuffle()
            for z=2, 4 do
				local tempMinorCard = MinorPoweDeck[1].takeObject({
					position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}),
                    flip           = true
                })
                tempMinorCard.setLock(true)
                tempMinorCard.setRotation({0.00, 180.00, 0.00})
                tempMinorCard.setPositionSmooth(vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}))
                tempMinorCard.createButton({
                    click_function = "PickPowerMinor",
                    function_owner = Global,
                    label          = "Pick Power",
                    position       = {0,0.3,1.47},
                    width          = 1000,
                    scale          = {0.9,1,0.5},
                    --height         = 340,
                    font_size      = 180,
                    color          = {71/255,48/255,32/255,0.6},
                    font_color     = {1,1,1},
                    tooltip = "Pick Power Card to your hand"
                })
				wt(0.2)
            end
    elseif MinorPoweDeck[1].tag == "Deck" then
            NumberCardMinor = MinorPoweDeck[1].getQuantity()
            if NumberCardMinor < 4 then
                wt(1)
                for i=1 , NumberCardMinor do
		            local tempMinorCard = MinorPoweDeck[1].takeObject({
		                position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                        flip           = true
                    })
                    tempMinorCard.createButton({
                        click_function = "PickPowerMinor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale          = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.6},
                        font_color     = {1,1,1},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMinorCard.setLock(true)
                end
                MinorPoweDeck = getObjectFromGUID("55b275").getObjects()
				MinorPoweZone = getObjectFromGUID("cb16ab")
		        MinorPoweDeck[1].setPositionSmooth({MinorPoweZone.getPosition().x, MinorPoweZone.getPosition().y, MinorPoweZone.getPosition().z})
				MinorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
				MinorPoweDeck[1].shuffle()
                wt(1)
                for z=(NumberCardMinor+1), 4 do
		            local tempMinorCard = MinorPoweDeck[1].takeObject({
		                position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}),
                        flip           = true
                    })
                    tempMinorCard.createButton({
                        click_function = "PickPowerMinor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale          = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.6},
                        font_color     = {1,1,1},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMinorCard.setLock(true)
					wt(0.2)
                end
            else
                for i=1,4 do
		            local tempMinorCard = MinorPoweDeck[1].takeObject({
		                position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                        flip           = true
                    })
                    tempMinorCard.createButton({
                        click_function = "PickPowerMinor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale          = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.8},
                        font_color     = {238/255,235/255,185/255},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMinorCard.setLock(true)
					wt(0.2)
                end
            end
    end
    else

    end
    return 1
end
scriptWorkingCard = 0
scriptWorkingCardC = 0
function MajorPower()
	local player_color = majorPowerCol
	local altClicked = majorPowerAlt
	yHeight = seaTile.getPosition().y + 0.1
	MajorPowerDiscardZone = getObjectFromGUID("eaf864")
	MajorPowerDiscardZonePos = MajorPowerDiscardZone.getPosition()
	MajorPoweZone = getObjectFromGUID("089896")
	MajorPoweDeck = MajorPoweZone.getObjects()
    if scriptWorkingCardC == 0 then
        scriptWorkingCardC = 1
	-- clear the zone!	yHeight = seaTile.getPosition().y + 0.1
	local handPos = Player[player_color].getHandTransform().position
	local powerDealCentre = vecSum({handPos.x,yHeight,handPos.z},handOffset)
	local xPadding = 4.4
	local hits = getPowerZoneObjects(handPos)
	local cardPlaceOffsetXs = {
		-(2.5*xPadding)+1*xPadding,
		-(2.5*xPadding)+2*xPadding,
		-(2.5*xPadding)+3*xPadding,
		-(2.5*xPadding)+4*xPadding,
	}
    for o, obj in pairs(hits) do
        obj.setLock(false)
        obj.setPositionSmooth({MajorPowerDiscardZonePos.x, MajorPowerDiscardZonePos.y+o/10, MajorPowerDiscardZonePos.z})
        obj.setRotationSmooth({0.00, 180.00, 0.00})
		obj.clearButtons()
		wt(0.2)
    end
    wt(0.5)
    scriptWorkingCardC = 0
    if MajorPoweDeck[1] == nil then
        wt(1)
		MajorPoweDeck = MajorPowerDiscardZone.getObjects()
        MajorPoweDeck[1].setPositionSmooth({MajorPoweZone.getPosition().x, MajorPoweZone.getPosition().y, MajorPoweZone.getPosition().z})
		MajorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
        MajorPoweDeck[1].shuffle()
        wt(1)
        for z=1, 4 do
			local tempMajorCard = MajorPoweDeck[1].takeObject({
				position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                flip           = true
            })
            tempMajorCard.createButton({
                click_function = "PickPowerMajor",
                function_owner = Global,
                label          = "Pick Power",
                position       = {0,0.3,1.47},
                width          = 1000,
                scale          = {0.9,1,0.5},
                --height         = 340,
                font_size      = 180,
                color          = {71/255,48/255,32/255,0.6},
                font_color     = {1,1,1},
                tooltip = "Pick Power Card to your hand"
            })
			tempMajorCard.setLock(true)
			wt(0.2)
        end
    elseif MajorPoweDeck[1].tag == "Card" then
            MajorPoweDeck[1].setPositionSmooth(vecSum(powerDealCentre,{cardPlaceOffsetXs[1],0,0}))
            MajorPoweDeck[1].setRotationSmooth({0.00, 180.00, 0.00})
            MajorPoweDeck[1].createButton({
                click_function = "PickPowerMajor",
                function_owner = Global,
                label          = "Pick Power",
                position       = {0,0.3,1.47},
                width          = 1000,
                scale          = {0.9,1,0.5},
                --height         = 340,
                font_size      = 180,
                color          = {71/255,48/255,32/255,0.6},
                font_color     = {1,1,1},
                tooltip = "Pick Power Card to your hand"
            })
			MajorPoweDeck[1].setLock(true)
            wt(1.5)
            MajorPoweDeck = getObjectFromGUID("eaf864").getObjects()
			MajorPoweZone = getObjectFromGUID("089896")
	        MajorPoweDeck[1].setPositionSmooth({MajorPoweZone.getPosition().x, MajorPoweZone.getPosition().y, MajorPoweZone.getPosition().z})
			MajorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
	        MajorPoweDeck[1].shuffle()
            for z=2, 4 do
				local tempMajorCard = MajorPoweDeck[1].takeObject({
					position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}),
                    flip           = true
                })
                tempMajorCard.setLock(true)
                tempMajorCard.setRotation({0.00, 180.00, 0.00})
                tempMajorCard.setPositionSmooth(vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}))
                tempMajorCard.createButton({
                    click_function = "PickPowerMajor",
                    function_owner = Global,
                    label          = "Pick Power",
                    position       = {0,0.3,1.47},
                    width          = 1000,
                    scale          = {0.9,1,0.5},
                    --height         = 340,
                    font_size      = 180,
                    color          = {71/255,48/255,32/255,0.6},
                    font_color     = {1,1,1},
                    tooltip = "Pick Power Card to your hand"
                })
				wt(0.2)
            end
    elseif MajorPoweDeck[1].tag == "Deck" then
            NumberCardMajor = MajorPoweDeck[1].getQuantity()
            if  NumberCardMajor < 4 then
                wt(1)
                for i=1, NumberCardMajor do
					local tempMajorCard = MajorPoweDeck[1].takeObject({
						position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                        flip           = true
                    })
                    tempMajorCard.createButton({
                        click_function = "PickPowerMajor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale          = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.6},
                        font_color     = {1,1,1},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMajorCard.setLock(true)
					wt(0.2)
                end
                MajorPoweDeck = MajorPowerDiscardZone.getObjects()
				MajorPoweZone = getObjectFromGUID("089896")
		        MajorPoweDeck[1].setPositionSmooth({MajorPoweZone.getPosition().x, MajorPoweZone.getPosition().y, MajorPoweZone.getPosition().z})
				MajorPoweDeck[1].setRotationSmooth({0.00, 180.00, 180})
				MajorPoweDeck[1].shuffle()
                wt(1)
                for z=(NumberCardMajor+1), 4 do
					local tempMajorCard = MajorPoweDeck[1].takeObject({
						position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[z],0,0}),
                        flip           = true
                    })
                    tempMajorCard.createButton({
                        click_function = "PickPowerMajor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale           = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.6},
                        font_color     = {1,1,1},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMajorCard.setLock(true)
					wt(0.2)
                end
            else
                for i=1, 4 do
					local tempMajorCard = MajorPoweDeck[1].takeObject({
						position       = vecSum(powerDealCentre,{cardPlaceOffsetXs[i],0,0}),
                        flip           = true
                    })
                    tempMajorCard.createButton({
                        click_function = "PickPowerMajor",
                        function_owner = Global,
                        label          = "Pick Power",
                        position       = {0,0.3,1.47},
                        width          = 1000,
                        scale          = {0.9,1,0.5},
                        --height         = 340,
                        font_size      = 180,
                        color          = {71/255,48/255,32/255,0.8},
                        font_color     = {238/255,235/255,185/255},
                        tooltip = "Pick Power Card to your hand"
                    })
					tempMajorCard.setLock(true)
					wt(0.2)
                end
            end
    end
    else

    end
    return 1
end
----
function PickPowerMinorC()
	local cMinorcd = CMinorcardo
	local cMinorcol = CMinorplayero
    cMinorcd.deal(1,cMinorcol)
    cMinorcd.removeButton(0)
	cMinorcd.setLock(false)
    wt(0.5)
	local handPos = Player[cMinorcol].getHandTransform().position
    local minor4CardZoneObjects = getPowerZoneObjects(handPos)
	local minorDiscardZone = getObjectFromGUID("55b275")
    for o, obj in ipairs(minor4CardZoneObjects) do
        obj.setPositionSmooth({minorDiscardZone.getPosition().x, minorDiscardZone.getPosition().y+o/10, minorDiscardZone.getPosition().z})
        --obj.setRotationSmooth({0.00, 180.00, 180})
		wt(0.2)
		obj.removeButton(0)
		obj.setLock(false)
    end
    return 1
end
function PickPowerMinor(cardo,playero)
    CMinorcardo = cardo
    CMinorplayero = playero
    startLuaCoroutine(Global, "PickPowerMinorC")
end
----
function PickPowerMajorC()
	local cMajorcd = CMajorcardo
	local cMajorcol = CMajorplayero
    cMajorcd.deal(1,cMajorcol)
    cMajorcd.removeButton(0)
	cMajorcd.setLock(false)
    wt(0.5)
	local handPos = Player[cMajorcol].getHandTransform().position
    local major4CardZoneObjects = getPowerZoneObjects(handPos)
	local majorDiscardZone = getObjectFromGUID("eaf864")
    for o, obj in ipairs(major4CardZoneObjects) do
        obj.setPositionSmooth({majorDiscardZone.getPosition().x, majorDiscardZone.getPosition().y+o/10, majorDiscardZone.getPosition().z})
        --obj.setRotationSmooth({0.00, 180.00, 180})
		wt(0.2)
		obj.removeButton(0)
		obj.setLock(false)
    end
    return 1
end
function PickPowerMajor(cardo,playero)
    CMajorcardo = cardo
    CMajorplayero = playero
    startLuaCoroutine(Global, "PickPowerMajorC")
end

function SetupGame()
	if #getMaps() == 0 and #getThematicMaps() == 0 then
		if player4 == false and player3 == false and player2 == false and player1 == false then
	        broadcastToAll("Choose number of players", {1,0,0})
			return 0
		end
	    if canStart == false then
	        broadcastToAll("Please wait for expansion cards to be added", {1,0,0})
			return 0
	    end
	end
	if #getMaps() > 0 and #getThematicMaps() > 0 then
		broadcastToAll("You cannot mix and match standard and thematic maps", {1,0,0})
		return 0
	end
	if #getMaps() > 0 or #getThematicMaps() > 0 then
		if #getMaps() == 4 or #getThematicMaps() == 4 then
			player4 = true
			player3 = false
			player2 = false
			player1 = false
	    elseif #getMaps() == 3 or #getThematicMaps() == 3 then
			player4 = false
			player3 = true
			player2 = false
			player1 = false
	    elseif #getMaps() == 2 or #getThematicMaps() == 2 then
			player4 = false
			player3 = false
			player2 = true
			player1 = false
	    elseif #getMaps() == 1 or #getThematicMaps() == 1 then
			player4 = false
			player3 = false
			player2 = false
			player1 = true
	    end
	end
	if adversaryName == "England" and adversaryLevel >= 5 then
		newTownBag = getObjectFromGUID("942899")
		newCityBag = getObjectFromGUID("cb7231")
		townBag.setPositionSmooth({newTownBag.getPosition().x,newTownBag.getPosition().y,newTownBag.getPosition().z})
		cityBag.setPositionSmooth({newCityBag.getPosition().x,newCityBag.getPosition().y,newCityBag.getPosition().z})
		newTownBag.setPositionSmooth({townBag.getPosition().x,townBag.getPosition().y,townBag.getPosition().z})
		newCityBag.setPositionSmooth({cityBag.getPosition().x,cityBag.getPosition().y,cityBag.getPosition().z})
		townBag = newTownBag
		cityBag = newCityBag
	end
	Global.setVectorLines({})
	getObjectFromGUID("d11797").destruct() -- remove intro text
	getObjectFromGUID("096908").destruct()
	getObjectFromGUID("b33ba9").destruct()
	SetupChecker.setRotation({180,0,0})
	startLuaCoroutine(Global, "SetupAdversary")
    startLuaCoroutine(Global, "spiritPower")
    startLuaCoroutine(Global, "SetupGameC")
    startLuaCoroutine(Global, "SetupFear")
    startLuaCoroutine(Global, "SetupInvaderDeck")
end
function SetupAdversary()
	BrandenburgPrussia = getObjectFromGUID("8a796d")
	England = getObjectFromGUID("fad468")
	France = getObjectFromGUID("d2249d")
	Sweden = getObjectFromGUID("7f6e53")

	targetScale = 1.53
	currentScale = BrandenburgPrussia.getScale()[1]
	scaleMult = (currentScale - targetScale)/20
	for i = 1, 17 do
		wt(0.02)
		BrandenburgPrussia.setScale({currentScale-scaleMult*i,1.00,currentScale-scaleMult*i})
		England.setScale({currentScale-scaleMult*i,1.00,currentScale-scaleMult*i})
		France.setScale({currentScale-scaleMult*i,1.00,currentScale-scaleMult*i})
		Sweden.setScale({currentScale-scaleMult*i,1.00,currentScale-scaleMult*i})
	end
	local adversPos = {-44.91, 1.5, 19.86}
	if adversaryName == "Brandenburg-Prussia" then
		England.flip()
		wt(0.2)
		England.setPositionSmooth(adversPos)
		France.flip()
		wt(0.2)
		France.setPositionSmooth(adversPos)
		Sweden.flip()
		wt(0.2)
		Sweden.setPositionSmooth(adversPos)
		wt(0.4)
		BrandenburgPrussia.setPositionSmooth(adversPos)
	end
	if adversaryName == "England" then
		BrandenburgPrussia.flip()
		wt(0.2)
		BrandenburgPrussia.setPositionSmooth(adversPos)
		France.flip()
		wt(0.2)
		France.setPositionSmooth(adversPos)
		Sweden.flip()
		wt(0.2)
		Sweden.setPositionSmooth(adversPos)
		wt(0.4)
		England.setPositionSmooth(adversPos)
	end
	if adversaryName == "France" then
		BrandenburgPrussia.flip()
		wt(0.2)
		BrandenburgPrussia.setPositionSmooth(adversPos)
		England.flip()
		wt(0.2)
		England.setPositionSmooth(adversPos)
		Sweden.flip()
		wt(0.2)
		Sweden.setPositionSmooth(adversPos)
		wt(0.4)
		France.setPositionSmooth(adversPos)
	end
	if adversaryName == "Sweden" then
		BrandenburgPrussia.flip()
		wt(0.2)
		BrandenburgPrussia.setPositionSmooth(adversPos)
		England.flip()
		wt(0.2)
		England.setPositionSmooth(adversPos)
		France.flip()
		wt(0.2)
		France.setPositionSmooth(adversPos)
		wt(0.4)
		Sweden.setPositionSmooth(adversPos)
	end
	if adversaryName == "None" then
		BrandenburgPrussia.flip()
		wt(0.2)
		BrandenburgPrussia.setPositionSmooth(adversPos)
		England.flip()
		wt(0.2)
		England.setPositionSmooth(adversPos)
		France.flip()
		wt(0.2)
		France.setPositionSmooth(adversPos)
		Sweden.flip()
		wt(0.2)
		Sweden.setPositionSmooth(adversPos)
	end
	return 1
end
function splitString(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
function SetupInvaderDeck()
	cardString = "111-2222-33333"
	if adversaryName == "Brandenburg-Prussia" then
		if adversaryLevel == 2 then
			cardString = "111-3-2222-3333"
		end
		if adversaryLevel == 3 then
			cardString = "11-3-2222-3333"
		end
		if adversaryLevel == 4 then
			cardString = "11-3-222-3333"
		end
		if adversaryLevel == 5 then
			cardString = "1-3-222-3333"
		end
		if adversaryLevel == 6 then
			cardString = "3-222-3333"
		end
	end
	cardString = string.reverse(cardString:gsub('-', ''))
	wt(1)
	local invaderPos = {-42.29, 1.5, -0.22}
	for i = 1, #cardString do
		local c = tonumber(cardString:sub(i,i))
		if c == 1 then
	        getObjectFromGUID("2e790f").shuffle()
	        getObjectFromGUID("2e790f").takeObject({
	            position       = invaderPos,
	        })
		    wt(0.2)
		end
		if c == 2 then
	        getObjectFromGUID("4e4ef4").shuffle()
	        getObjectFromGUID("4e4ef4").takeObject({
	            position       = invaderPos,
	        })
		    wt(0.2)
		end
		if c == 3 then
	        getObjectFromGUID("7d0f0f").shuffle()
	        getObjectFromGUID("7d0f0f").takeObject({
	            position       = invaderPos,
	        })
		    wt(0.2)
		end
	end
    return 1
end
function SetupFear()
	if adversaryName == "Brandenburg-Prussia" then
		if adversaryLevel == 1 then
			fearCards1 = 3
			fearCards2 = 3
			fearCards3 = 3
		end
		if adversaryLevel == 2 then
			fearCards1 = 3
			fearCards2 = 3
			fearCards3 = 3
		end
		if adversaryLevel == 3 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 4 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 5 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 6 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 4
		end
	end
	if adversaryName == "England" then
		if adversaryLevel == 1 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 2 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 3 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 4
		end
		if adversaryLevel == 4 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 5
		end
		if adversaryLevel == 5 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 5
		end
		if adversaryLevel == 6 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 4
		end
	end
	if adversaryName == "France" then
		if adversaryLevel == 1 then
			fearCards1 = 3
			fearCards2 = 3
			fearCards3 = 3
		end
		if adversaryLevel == 2 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 3 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 4 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 4
		end
		if adversaryLevel == 5 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 4
		end
		if adversaryLevel == 6 then
			fearCards1 = 4
			fearCards2 = 5
			fearCards3 = 5
		end
	end
	if adversaryName == "Sweden" then
		if adversaryLevel == 1 then
			fearCards1 = 3
			fearCards2 = 3
			fearCards3 = 3
		end
		if adversaryLevel == 2 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 3 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 3
		end
		if adversaryLevel == 4 then
			fearCards1 = 3
			fearCards2 = 4
			fearCards3 = 4
		end
		if adversaryLevel == 5 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 4
		end
		if adversaryLevel == 6 then
			fearCards1 = 4
			fearCards2 = 4
			fearCards3 = 5
		end
	end
    FearDeck.shuffle()
    wt(1)
	local fearPos = {-55.28, 1.5, 9.47}
    for w=1, fearCards3 do
        FearDeck.takeObject({
            position       = fearPos,
            rotation       = {0.00, 180.00, 180.00},
        })
    end
    wt(1)
    Terror3.setPositionSmooth(fearPos)
    FearDeck.shuffle()
    wt(1)
    for w=1, fearCards2 do
        FearDeck.takeObject({
            position       = fearPos,
            rotation       = {0.00, 180.00, 180.00},
        })
    end
    wt(1)
    Terror2.setPositionSmooth(fearPos)
    FearDeck.shuffle()
    wt(1)
    for w=1, fearCards1 do
        FearDeck.takeObject({
            position       = fearPos,
            rotation       = {0.00, 180.00, 180.00},
        })
    end
    return 1
end
function setupFearTokens(x)
	if adversaryName == "England" and adversaryLevel == 6 then
		aidBoard.editButton({index = 0, label = tostring(x*5)})
		aidBoard.editButton({index = 1, label = 0})
		fearCurrent = 0
		fearMax = x*5
	else
		aidBoard.editButton({index = 0, label = tostring(x*4)})
		aidBoard.editButton({index = 1, label = 0})
		fearCurrent = 0
		fearMax = x*4
	end
end
function setupBlightTokens(y)
	blightInfinite = getObjectFromGUID("3595ff")
	blightBag.reset()
    for u=1 , y*2 do
        blightInfinite.takeObject({position = {blightBag.getPosition().x, blightBag.getPosition().y+u/2, blightBag.getPosition().z}})
    end
end
blightedIslandCard = nil
function setupBlightedIslandCards()
	blightedIslandZoneObjects = getObjectFromGUID("b0b6d8").getObjects()
	blightedIslandDeck = nil
	for k,v in ipairs (blightedIslandZoneObjects) do
		if v.tag == "Deck" then
			if v.getCustomObject()[1].face == "http://cloud-3.steamusercontent.com/ugc/868489312394412379/74C0CFC6A0FA95FBA5681980A69A3D9C1DFC98D8/" then
				blightedIslandDeck = v
			end
		end
	end
	if blightedIslandDeck ~= nil then
		blightedIslandDeck.shuffle()
		wt(0.3)
		blightedIslandDeck.shuffle()
		blightedIslandCards = blightedIslandDeck.getObjects()
		for i=1,#blightedIslandCards-1 do
			wt(0.2)
			blightedIslandDeck.takeObject({
				position       = {-64.40, 1.5, 20.60},
			})
		end
        wt(1)
		addBlightedIslandButton()
	end
end
function addBlightedIslandButton()
	blightedIslandZoneObjects = getObjectFromGUID("b0b6d8").getObjects()
	for k,v in ipairs (blightedIslandZoneObjects) do
		if v.tag == "Card" then
			blightedIslandCard = v
			blightedIslandCard.setLock(true)
			aidBoard.createButton({
				click_function = "BlightIslandButton",
				function_owner = Global,
				label          = "Blighted Island",
				position       = {1.146,0.4,1.45},
				rotation       = {0,0,0},
				width          = 1600,
				height         = 200,
				scale          = {0.2,1,0.2},
				height         = 270,
				font_size      = 220,
				color          = {20/255,20/255,20/255,0.6},
				font_color     = {1,1,1},
				tooltip        = "Click here when the blight stack has been reduced to 0"
			})
		end
	end
end
function BlightIslandButton(buttonOwnerObject, playerColor)
	if #blightBag.getObjects() == 0 then -- blightBag must be empty to flip this card!
		if blightedIslandTimer == 0 then
			broadcastToColor("Double-click to Blight the island!", playerColor, {1,0.7,0})
		end
		startLuaCoroutine(Global, "BlightedIslandTimer")
	else
		return
	end
end
blightedIslandTimer = 0
function BlightedIslandTimer()
	if blightedIslandTimer == 1 then
		blightedIslandTimer = 0
		BlightedIslandFlip()
	else
		blightedIslandTimer = 1
		wt(1)
		blightedIslandTimer = 0
	end
	return 1
end
function BlightedIslandFlip()
    for i,v in pairs(aidBoard.getButtons()) do
        if v.label == "Blighted Island" then
            aidBoard.editButton({
                index = v.index,
                label = "",
                width = 0,
                height = 0,
            })
        end
    end
	gameStart = false -- to disable the blight bag removal warning
    blightedIslandCard.setRotationSmooth({0,180,0},false,false)
	blightedIslandTokenCount = blightCardMultipliers[blightedIslandCard.getGUID()]
	blightBag.setLock(true)
	blightBag.setPosition(vecSum(blightBag.getPosition(),{0,1,0}))
    playerCountFromMaps = math.max(#getMaps(),#getThematicMaps())
	blightedIslandTokenCount = blightedIslandTokenCount * playerCountFromMaps
	for i = 1, blightedIslandTokenCount do
		blightBagInfinite.takeObject({
			position = vecSum(blightBag.getPosition(), {0,i*0.2,0})
		})
		wt(0.1)
	end
	wt(1)
	broadcastToAll("BLIGHTED ISLAND", {1,0,0})
	wt(3)
	blightBag.setPosition(vecSum(blightBag.getPosition(),{0,-1,-1}))
	blightBag.setLock(false)
	broadcastToAll(blightedIslandTokenCount.." Blight Tokens Added", {1,0,0})
	gameStart = true -- to re-enable the placing of tokens via macros
	wt(5)
	broadcastToAll("Remember to check the blighted island effect", {1,0.7,0})

	return 1
end
function englandSnap()
	snapPoints = aidBoard.getSnapPoints()
	scax = aidBoard.getScale().x
	scaz = aidBoard.getScale().z
	newSnapPoints = {}
	for i,v in ipairs(snapPoints) do
		q = math.floor(v.rotation.y / 10)
		if q > 7 and q < 9 then
			--log (v)
		else
			newSnapPoint = {
				position = {v.position.x/scax, v.position.y, v.position.z/scaz},
				rotation = {v.rotation.x, v.rotation.y+180, v.rotation.z},
				rotation_snap = v.rotation_snap,
			}
			table.insert(newSnapPoints,newSnapPoint)
		end
	end
	aidBoard.setSnapPoints(newSnapPoints)
end
function SetupGameC()
	-- Shuffle Decks
	getObjectFromGUID("ab6881").shuffle()
	wt(0.1)
	getObjectFromGUID("ab6881").shuffle()
	wt(0.1)
    getObjectFromGUID("cb16ab").getObjects()[1].shuffle()
	wt(0.1)
    getObjectFromGUID("cb16ab").getObjects()[1].shuffle()
	wt(0.1)
    getObjectFromGUID("089896").getObjects()[1].shuffle()
	wt(0.1)
    getObjectFromGUID("089896").getObjects()[1].shuffle()

	-- Place England

	if adversaryName == "England" and adversaryLevel >= 3 then -- place 2nd build board
		getObjectFromGUID("e5d18b").setPositionSmooth(aidBoard.positionToWorld({0.41,0.1,1.93}), false, false)
		getObjectFromGUID("e5d18b").setLock(true)
		-- remove snap point on aid board
		englandSnap()
	end
    if adversaryName == "England" and adversaryLevel >= 5 then
        townHealth.TextTool.setValue("3")
        townHealth.TextTool.setFontColor({1,0.2,0.2})
        cityHealth.TextTool.setValue("4")
        cityHealth.TextTool.setFontColor({1,0.2,0.2})
    end
	if adversaryName == "England" and adversaryLevel >= 1 then
		getObjectFromGUID("eb5ab2").setPositionSmooth(aidBoard.positionToWorld({-0.72,0.1,2.26}), false, false)
	end
	if adversaryName == "France" and adversaryLevel >= 2 then
		getObjectFromGUID("be2c91").setPositionSmooth(aidBoard.positionToWorld({-0.72,0.1,2.26}), false, false)
		slaveRebellionEventCard = getObjectFromGUID("ac30fa")
		eventDeck = getObjectFromGUID("ab6881")
		card1 = eventDeck.takeObject({
			position = {eventDeck.getPosition().x, eventDeck.getPosition().y + 2, eventDeck.getPosition().z}
		})
		card2 = eventDeck.takeObject({
			position = {eventDeck.getPosition().x, eventDeck.getPosition().y + 2.5, eventDeck.getPosition().z}
		})
		card3 = eventDeck.takeObject({
			position = {eventDeck.getPosition().x, eventDeck.getPosition().y + 3, eventDeck.getPosition().z}
		})
		slaveRebellionEventCard.setRotationSmooth({0.00, 180.00, 180.00}, false, true)
		slaveRebellionEventCard.setPositionSmooth({eventDeck.getPosition().x, eventDeck.getPosition().y + 0.1, eventDeck.getPosition().z}, false, true)
	end
	if adversaryName == "France" and adversaryLevel >= 1 then
		getObjectFromGUID("f4a568").setPositionSmooth(aidBoard.positionToWorld({-1.24,0.1,2.26}), false, false)
		if player1 then
			townLimit = 7
		elseif player2 then
			townLimit = 14
		elseif player3 then
			townLimit = 21
		elseif player4 then
			townLimit = 28
		end
		for i=1,#townBag.getObjects() do
			if i > townLimit then
				w = townBag.takeObject({
					position = {townBag.getPosition().x,-2,townBag.getPosition().z},
					smooth = false
				})
				wt(0.01)
				w.destruct()
			end
		end
	end
    if adversaryName == "Sweden" and adversaryLevel >= 3 then
        townDamage.TextTool.setValue("3")
        townDamage.TextTool.setFontColor({1,0.2,0.2})
        cityDamage.TextTool.setValue("5")
        cityDamage.TextTool.setFontColor({1,0.2,0.2})
    end
	if adversaryName == "Sweden" and adversaryLevel >= 1 then
		getObjectFromGUID("16ab25").setPositionSmooth(aidBoard.positionToWorld({-0.2,0.1,2.26}), false, false)
	end

	wt(1)
	if #getMaps() == 0 and #getThematicMaps() == 0 then
	    if player4 == true then
	        setupFearTokens(4)
		    StandardMapBag.shuffle()
			if boardType == "Standard" then
			    MapPlacen(4,posMap,rotMap)
			else
				MapPlacen(4,posMapThem,rotMapThem)
			end
	        setupBlightTokens(4)
			setupBlightedIslandCards()
			wt(1)
	    elseif player3 == true then
	        setupFearTokens(3)
		    StandardMapBag.shuffle()
			if boardType == "Standard" then
		    	MapPlacen(3,posMap3,rotMap3)
			else
				MapPlacen(3,posMapThem3,rotMapThem3)
			end
	        setupBlightTokens(3)
			setupBlightedIslandCards()
			wt(1)
	    elseif player2 == true then
	        setupFearTokens(2)
		    StandardMapBag.shuffle()
			if boardType == "Standard" then
		    	MapPlacen(2,posMap2,rotMap2)
			else
				MapPlacen(2,posMapThem2,rotMapThem2)
			end
	        setupBlightTokens(2)
			setupBlightedIslandCards()
			wt(1)
	    elseif player1 == true then
	        setupFearTokens(1)
		    StandardMapBag.shuffle()
			if boardType == "Standard" then
		    	MapPlacen(1,posMap1,rotMap1)
			else
				MapPlacen(1,posMapThem1,rotMapThem1)
			end
	        setupBlightTokens(1)
			setupBlightedIslandCards()
			wt(2)
	    end
	else
	    if #getMaps() == 6 or #getThematicMaps() == 6 then
	        setupFearTokens(6)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(6)
			setupBlightedIslandCards()
			wt(1)
	    elseif #getMaps() == 5 or #getThematicMaps() == 5 then
	        setupFearTokens(5)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(5)
			setupBlightedIslandCards()
			wt(1)
	    elseif #getMaps() == 4 or #getThematicMaps() == 4 then
	        setupFearTokens(4)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(4)
			setupBlightedIslandCards()
			wt(1)
	    elseif #getMaps() == 3 or #getThematicMaps() == 3 then
	        setupFearTokens(3)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(3)
			setupBlightedIslandCards()
			wt(1)
	    elseif #getMaps() == 2 or #getThematicMaps() == 2 then
	        setupFearTokens(2)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(2)
			setupBlightedIslandCards()
			wt(1)
	    elseif #getMaps() == 1 or #getThematicMaps() == 1 then
	        setupFearTokens(1)
		    StandardMapBag.shuffle()
		    MapPlaceCustom()
	        setupBlightTokens(1)
			setupBlightedIslandCards()
			wt(2)
	    end
	end

	for i,v in ipairs(interactableObjectsToDisableOnStart) do
		getObjectFromGUID(v).setLock(true)
		getObjectFromGUID(v).interactable = false
	end
	gameStart = true
	difficultyString = ""
	if difficulty == -1 then
        difficulty = 0
    end
	if adversaryName == "None" then
		difficultyString = "No Adversary - Difficulty 0"
        difficulty = 0
	else
		difficultyString = adversaryName.." level "..adversaryLevel.." - Difficulty "..difficulty
	end
	getObjectFromGUID("14fd68").createButton({ -- add difficulty text
		click_function = "nullFunc",
		function_owner = Global,
		label          = difficultyString,
		position       = {0,1.4,0},
		rotation       = {0,180,0},
		font_size      = 500,
		font_color     = {1,1,1},
		width          = 0,
		height         = 0,
	})
	wt(1)
	SetupChecker.clearButtons()
	SetupChecker.setPosition(aidBoard.positionToWorld({0,-0.2,9}))
	wt(0.1)
	SetupChecker.createButton({
		click_function = "timePasses",
		function_owner = Global,
		position       = {0,0.6,0},
		label          = "Time Passes",
		width          = 1800,
		height         = 600,
		font_size      = 300,
	})
	gameStarted = 1
	startLuaCoroutine(Global,"zoneDestroyTimerCoro")
	broadcastToAll("Game Ready!", {0,0.8,0})
	SetupChecker.setRotation({0,180,0})
	wt(2)
	setLookingForPlayers(false)
	broadcastToAll("Looking for Players turned off!", {1,0.7,0})
	wt(5)
	broadcastToAll("Don't forget the initial explore action!", {1,0.7,0})
    return 1
end
------
quotes = {
	{"Time passes, and little by little everything that we have spoken in falsehood becomes true.","Marcel Proust"},
	{"Time passes so slowly if you are unaware of it and so quickly if you are aware of it.","Marc Bolan"},
	{"Time goes, you say, Ah no! Alas, Time stays, we go.","Henry Austin Dobson"},
	{"Time wastes our bodies and our wits, but we waste time, so we are quits.","Anonymous"},
	{"Time has no divisions to mark its passage, there is never a thunderstorm or blare of trumpets to announce the beginning of a new month or year. Even when a new century begins it is only we mortals who ring bells and fire off pistols.","Thomas Mann"},
	{"Time. Like a petal in the wind, Flows softly by. As old lives are taken, New ones begin. A continual chain, Which lasts throughout eternity. Every life but a minute in time, But each of equal importance.","Cindy Cheney"},
	{"The long unmeasured pulse of time moves everything. There is nothing hidden that it cannot bring to light, nothing once known that may not become unknown. Nothing is impossible.","Sophocles"},
	{"Indifferent to the affairs of men, time runs out, precise, heedless, exact, and immutable in rhythm.","Erwin Sylvanus"},
	{"Time is a sort of river of passing events, and strong is its current; no sooner is a thing brought to sight than it is swept by and another takes its place, and this too will be swept away.","Marcus Aurelius"},
	{"Time is a great teacher, but unfortunately it kills all its pupils.","Hector Louis Berlioz"},
	{"Half our time is spent trying to find something to do with the time we have rushed through life trying to save.","Will Rogers"},
	{"The bad news is time flies. The good news is you're the pilot.","Michael Althsuler"},
	{"Time flies never to be recalled.","Virgil"},
	{"Time flies over us, but leaves its shadow behind.","Nathaniel Hawthorne"},
	{"Time is the most undefinable yet paradoxical of things; the past is gone, the future is not come, and the present becomes the past even while we attempt to define it, and, like the flash of lightning, at once exists and expires.","Charles Caleb Colton"},
	{"Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma - which is living with the results of other people's thinking.","Steve Jobs"},
	{"Time and tide wait for no man, but time always stands still for a woman of 30.","Robert Frost"},
	{"Time, you old gypsy man, will you not stay, put up your caravan just for one day?","Ralph Hodgson"},
	{"The more sand that has escaped from the hourglass of our life, the clearer we should see through it.","Jean Paul"},
	{"Don't say you don't have enough time. You have exactly the same number of hours per day that were given to Helen Keller, Pasteur, Michaelangelo, Mother Teresa, Leonardo da Vinci, Thomas Jefferson, and Albert Einstein.","H. Jackson Brown Junior"},
	{"Time is a brisk wind, for each hour it brings something new... but who can understand and measure its sharp breath, its mystery and its design?","Paracelsus"},
	{"Time forks perpetually toward innumerable futures.","Jorge Luis Borges"},
	{"As we speak cruel time is fleeing. Seize the day, believing as little as possible in the morrow.","Horace"},
	{"Idleness makes hours pass slowly and years swiftly. Activity makes the hours short and the years long.","Cesare Pavese"},
	{"Time does not pass, it continues.","Marty Rubin"},
	{"Time is free, but it's priceless. You can't own it, but you can use it. You can't keep it, but you can spend it. Once you've lost it you can never get it back.","Harvey McKay"},
	{"Time is more valuable than money. You can get more money, but you cannot get more time.","Jim Rohn"},
	{"Time is like a handful of sand- the tighter you grasp it, the faster it runs through your fingers","Anonymous"},
	{"Methinks I see the wanton hours flee, And as they pass, turn back and laugh at me.","George Villiers"},
	{"Better late than never, but never late is better","Anonymous"},
}
timePassing = false
function timePasses()
	if timePassing == false then
		timePassing = true
		startLuaCoroutine(Global, "timePassesCoro")
	end
end
function timePassesCoro()
	for _,object in pairs(upCast(seaTile,1,0,0.9)) do
		if string.find(object.getName(),"Town") then
			if object.getStateId() ~= 1 then object = object.setState(1) end
			object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
			if object.getRotation().z > 190 or object.getRotation().z < 170 or object.getRotation().x > 190 or object.getRotation().x < 170 or object.getRotation().y > 190 or object.getRotation().y < 170 then
				object.setRotationSmooth({0,270,0})
				object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
			end
		elseif string.find(object.getName(),"City") then
			if object.getStateId() ~= 1 then object = object.setState(1) end
			object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
		    if object.getRotation().z > 190 or object.getRotation().z < 170 or object.getRotation().x > 190 or object.getRotation().x < 170 or object.getRotation().y > 190 or object.getRotation().y < 170 then
				object.setRotationSmooth({0,180,0})
				object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
			end
		elseif object.getName() == "Dahan" then
			if ((object.getRotation().x > 190 and object.getRotation().x < 350) or (object.getRotation().x < 170 and object.getRotation().x > 10)) or (object.getRotation().z < 350 and object.getRotation().z > 10) then
				object.setRotationSmooth({0,0,0})
				object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
			end
		elseif ((object.getRotation().x > 190 and object.getRotation().x < 350) or (object.getRotation().x < 170 and object.getRotation().x > 10)) or (object.getRotation().z < 350 and object.getRotation().z > 10) then
			object.setRotationSmooth({0,0,0})
			object.setPositionSmooth(vecSum(object.getPosition(),{0,0.5,0}))
		end
	end
	broadcastToAll("Time Passes...", {1,0.7,0})
	quote = quotes[math.random(#quotes)]
	wt(3)
	broadcastToAll("\"" .. quote[1] .. "\"", quoteColor)
	wt(4)
	broadcastToAll("- " .. quote[2], quoteColor)
	wt(4)
	timePassing = false
	return 1
end
------
function test(LetterNumber,LetterNumberr)
    print(LetterNumber)
end
posMap = {
    {6.20, 1.08, 24.40},
    {24.70, 1.08, 22.66},
    {14.19, 1.08, 7.71},
    {-4.30, 1.08, 9.41}
}
rotMap = {
    {0.00, 180.00, 0.00},
    {0.00, 0.00, 0.00},
    {0.00, 0.00, 0.00},
    {0.00, 180.00, 0.00}
}
----
posMap3 = {
    {7.97, 1.08, 25.75},
    {21.40, 1.08, 17.17},
    {7.29, 1.08, 9.84}
}
rotMap3 = {
    {0.00, 177.29, 0.00},
    {0.00, 297.33, 0.00},
    {0.00, 57.55, 0.00}
}
----
posMap2 = {
    {12.23, 1.08, 24.28},
    {1.96, 1.08, 9.41}
}
rotMap2 = {
    {0.00, 180.76, 0.00},
    {0.00, 0.00, 0.00}
}
----
posMap1 = {
    {5.96, 1.08, 16.59}
}
rotMap1 = {
    {0.00, 180.00, 0.00}
}
----
----
posMapThem = {
	{12.71, 1.06, 10.03}, --E
	{-6.44, 1.06, 8.15}, --W
	{2.06, 1.06, 25.37}, --NE
    {-17.21, 1.06, 23.49}, --NW
}
rotMapThem = {
    {0.00, 180.00, 0.00},
    {0.00, 180.00, 0.00},
    {0.00, 180.00, 0.00},
    {0.00, 180.00, 0.00}
}
----
posMapThem3 = {
	{12.71, 1.06, 10.03}, --E
	{-6.44, 1.06, 8.15}, --W
	{2.06, 1.06, 25.37}, --NE
}
rotMapThem3 = {
	{0.00, 180.00, 0.00},
	{0.00, 180.00, 0.00},
	{0.00, 180.00, 0.00},
}
----
posMapThem2 = {
	{12.71, 1.06, 10.03}, --E
	{-6.44, 1.06, 8.15}, --W
}
rotMapThem2 = {
	{0.00, 180.00, 0.00},
    {0.00, 180.00, 0.00},
}
----
posMapThem1 = {
	{-10, 1.06, 10.03}, --E
}
rotMapThem1 = {
	{0.00, 180.00, 0.00},
}
----



posMapA = {
    ["City"] = {7.79, 1.55, 1.14},
    ["Dahan_1"] = {-5.52, 2.15, 4.04},
    ["Dahan_2"] = {-6.48, 2.15, 2.18},
    ["Dahan_3"] = {-2.44, 2.15, -3.73},
    ["Dahan_4"] = {6.40, 2.15, -2.42},
    ["Dahan_5"] = {8.05, 2.15, 5.98},
    ["Dahan_6"] = {10.18, 2.15, 5.80},
    ["Town"] = {-8.94, 1.96, -3.54},
    ["Blight"] = {2.66, 1.91, 4.95},
	["ExtraPlacement1"] = {2.00 ,1.96, -4.00}, -- Extra City on #1
	["ExtraPlacement2"] = {5.79, 1.55, 1.14}, -- Extra Town on #2
	["ExtraPlacement3"] = {11.48, 2.15, 4.98}, -- Extra Town on #3
	["FrancePlacement1"] =  {-7.48, 2.15, 0.18}, -- Extra French Town on Highest # without a town (7)
	["SwedenBlightLv2"] =  {-1.50, 1.91, 4.95}, -- Move Blight from #4 to #5
	["SwedenCityLv2"] =  {2.66, 1.91, 4.95}, -- Place City on #4
	["SwedenBlightLv6"] =  {-9.94, 1.96, -5.44}, -- Place Blight on #8
	["SwedenTownLv6"] =  {-7.44, 1.96, -5.54}, -- Place Town on #8
    ["Disease"] = {6.98, 2.15, 3.18},
    ["Beasts"] = {3.00, 1.96, -2.00},

}
---
posMapB = {
    ["City"] = {7.79, 1.55, 1.14},
    ["Dahan_1"] = {10.18, 2.15, 5.80},
    ["Dahan_2"] = {8.05, 2.15, 5.98},
    ["Dahan_3"] = {3.47, 2.15, -5.17},
    ["Dahan_4"] = {-5.52, 2.15, 4.04},
    ["Dahan_5"] = {-7.64, 2.15, -3.96},
    ["Dahan_6"] = {-6.87, 2.15, -5.28},
    ["Town"] = {-3.68, 1.96, -4.43},
    ["Blight"] = {1.73, 1.91, 4.44},
	["ExtraPlacement1"] = {3.00, 1.91, -3.50}, -- Extra City on #1
	["ExtraPlacement2"] = {5.79, 1.55, 1.14}, -- Extra Town on #2
	["ExtraPlacement3"] = {6.05, 2.15, 5.88}, -- Extra Town on #3
	["FrancePlacement1"] =  {-9.87, 2.15, -6.28}, -- Extra French Town on Highest # without a town (8)
	["SwedenBlightLv2"] =  {-1.73, 2.15, 0.00}, -- Move Blight from #4 to #5
	["SwedenCityLv2"] =  {1.73, 1.91, 4.44}, -- Place City on #4
	["SwedenBlightLv6"] =  {-10.94, 2.15, -4.66}, -- Place Blight on #8
	["SwedenTownLv6"] =  {-8.94, 2.15, -5.96}, -- Place Town on #8
    ["Disease"] = {5.79, 1.55, -1.14},
    ["Beasts"] = {-0.50, 1.96, -2.00},
}
---
posMapC = {
    ["City"] = {7.79, 1.55, 1.14},
    ["Dahan_1"] = {10.18, 2.15, 5.80},
    ["Dahan_2"] = {8.05, 2.15, 5.98},
    ["Dahan_3"] = {3.07, 2.15, -5.02},
    ["Dahan_4"] = {-0.49, 2.15, 0.08},
    ["Dahan_5"] = {-0.68, 2.15, 2.08},
    ["Dahan_6"] = {-2.44, 2.15, -3.73},
    ["Town"] = {-6.14, 1.96, 2.60},
    ["Blight"] = {0.75, 1.91, 1.31},
	["ExtraPlacement1"] = {1.08, 1.91, -5.21}, -- Extra City on #1
	["ExtraPlacement2"] = {5.79, 1.55, 1.14}, -- Extra Town on #2
	["ExtraPlacement3"] = {12.00, 2.15, 5.08}, -- Extra Town on #3
	["FrancePlacement1"] =  {-10.07, 2.15, -5.02}, -- Extra French Town on Highest # without a town (8)
	["SwedenBlightLv2"] =  {0.75, 1.91, 1.31}, -- Place Blight as usual in #5
	["SwedenCityLv2"] =  {1.73, 1.91, 5.24}, -- Place City on #4
	["SwedenBlightLv6"] =  {-10.64, 2.15, -4.66}, -- Place Blight on #8
	["SwedenTownLv6"] =  {-8.64, 2.15, -5.56}, -- Place Town on #8
    ["Disease"] = {4.14, 1.55, -0.60},
    ["Beasts"] = {-2.00, 1.96, 5.40},
}
---
posMapD = {
    ["City"] = {7.79, 1.55, 1.14},
    ["Dahan_1"] = {6.40, 2.15, -2.42},
    ["Dahan_2"] = {1.76, 2.15, -6.26},
    ["Dahan_3"] = {-0.35, 2.15, -5.38},
    ["Dahan_4"] = {-2.06, 2.15, -1.53},
    ["Dahan_5"] = {-6.10, 2.15, -1.56},
    ["Dahan_6"] = {-7.48, 2.15, 0.29},
    ["Town"] = {-5.45, 1.96, 0.52},
    ["Blight"] = {-0.84, 1.91, -0.61},
	["ExtraPlacement1"] = {-4.00, 1.96, -5.68}, -- Extra City on #1
	["ExtraPlacement2"] = {5.79, 1.55, 1.14}, -- Extra Town on #2
	["ExtraPlacement3"] = {10.00, 2.15, 5.08}, -- Extra Town on #3
	["FrancePlacement1"] =  {-10.00, 1.96, -5.68}, -- Extra French Town on Highest # without a town (8)
	["SwedenBlightLv2"] =  {-0.84, 1.91, -0.61}, -- Place Blight as usual in #5
	["SwedenCityLv2"] =  {1.73, 1.91, 4.44}, -- Place City on #4
	["SwedenBlightLv6"] =  {-10.64, 2.15, -4.56}, -- Place Blight on #8
	["SwedenTownLv6"] =  {-8.64, 2.15, -4.96}, -- Place Town on #8
    ["Disease"] = {3.79, 2.15, -0.54},
    ["Beasts"] = {9.40, 2.15, 7.08},
}
----

themMapNW = {
    -- 1
    ["Explorer_1"] = {-0.67,0.1,0.54},
    ["Explorer_11"] = {-0.57,0.1,0.92},
    ["Dahan_1"] = {-0.6,0.1,0.73},
	["ExtraPlacement1_1"] = {-0.99,0.1,0.36}, -- Extra City on #1
    -- 2
    ["City_2"] = {-1.06,0.1,-0.29},
	["ExtraPlacement2_2"] = {-1.31,0.1,-0.45}, -- Extra Town on #2
    -- 3
    ["Town_3"] = {-1.48,0.1,-1.07},
    ["Disease_3"] = {-1.19,0.1,-0.97},
	["ExtraPlacement3_3"] = {-1.77,0.1,-0.92}, -- Extra Town on #3
    -- 4
	["SwedenCityLv2_4"] = {-0.6,0.1,-0.83}, -- Place City on #4
    -- 5

    -- 6
    ["Dahan_6"] = {-0.01,0.1,0.88},
    ["Dahan_66"] = {0.31,0.1,0.66},
    -- 7
    ["Dahan_77"] = {0.92,0.1,-0.38},
    -- 8
    ["Explorer_8"] = {0.88,0.1,0.29},
    ["Dahan_8"] = {1.19,0.1,0.31},
	["SwedenBlightLv6_8"] = {0.84,0.1,0.47}, -- Place Blight on #8
	["SwedenTownLv6_8"] = {1.1,0.1,0.52}, -- Place Town on #8
    -- 9
    ["Dahan_9"] = {1.38,0.1,0.97},
	["FrancePlacement1_9"] = {1.64,0.1,0.86}, -- Extra French Town on Highest # without a town (7)
}
themMapNE = {
    -- 1
    ["City_1"] = {0.55,0.1,-0.99},
	["ExtraPlacement1_1"] = {0.21,0.1,-1.04}, -- Extra City on #1
    -- 2
    ["Wilds_2"] = {0.92,0.1,-0.3},
	["ExtraPlacement2_2"] = {0.67,0.1,-0.39}, -- Extra Town on #2
    -- 3
    ["Dahan_3"] = {0.71,0.1,0.27},
	["ExtraPlacement3_3"] = {1.13,0.1,0.39}, -- Extra Town on #3
    -- 4
    ["Dahan_4"] = {1.25,0.1,0.83},
	["SwedenCityLv2_4"] = {1.62,0.1,0.59}, -- Place City on #4
    -- 5
    ["Town_5"] = {-0.38,0.1,-0.62},
    -- 6
    ["Dahan_6"] = {-0.6,0.1,0.89},
    ["Dahan_66"] = {-0.28,0.1,0.92},
    -- 7
    ["Explorer_7"] = {-0.37,0.1,-0.19},
    ["Explorer_77"] = {-0.25,0.1,-0.02},
    ["Explorer_777"] = {-0.08,0.1,0.07},
    ["Dahan_7"] = {-0.58,0.1,0.01},
    ["Dahan_77"] = {-0.72,0.1,0.27},
    ["Dahan_777"] = {-0.5,0.1,0.39},
    -- 8
    ["SwedenBlightLv6_8"] = {-0.81,0.1,-0.25}, -- Place Blight on #8
    ["SwedenTownLv6_8"] = {-1.39,0.1,-0.18}, -- Place Town on #8
    -- 9
    ["Beasts_9"] = {-1.62,0.1,-0.89},
    ["Disease_9"] = {-1.36,0.1,-0.96},
	["FrancePlacement1_9"] = {-1.97,0.1,-0.83}, -- Extra French Town on Highest # without a town (7)
}
themMapW = {
    -- 1
    ["Town_1"] = {-0.71,0.1,0.57},
    ["Town_11"] = {-0.66,0.1,0.92},
    ["Dahan_1"] = {-0.23,0.1,0.58},
    ["Dahan_11"] = {0.04,0.1,0.58},
	["ExtraPlacement1_1"] = {-0.52,0.1,0.44}, -- Extra City on #1
    -- 2
    ["Town_2"] = {-1.1,0.1,0.36},
	["ExtraPlacement2_2"] = {-1.15,0.1,0.16}, -- Extra Town on #2
    -- 3
    ["Wilds_3"] = {-1.58,0.1,-0.7},
	["ExtraPlacement3_3"] = {-1.86,0.1,-0.78}, -- Extra Town on #3
    -- 4
    ["Beasts_4"] = {-1.01,0.1,-0.93},
	["SwedenCityLv2_4"] = {-1.22,0.1,-0.9}, -- Place City on #4
    -- 5
    ["Explorer_5"] = {-0.7,0.1,-0.12},
    -- 6
    ["Explorer_6"] = {-0.47,0.1,-0.87},
    ["Dahan_6"] = {0,0.1,-0.87},
    -- 7
    ["Dahan_7"] = {0.68,0.1,-0.37},
    ["Dahan_77"] = {0.9,0.1,-0.51},
    -- 8
    ["Dahan_8"] = {0.44,0.1,0.1},
    ["Dahan_88"] = {0.62,0.1,0.04},
	["SwedenBlightLv6_8"] = {0.99,0.1,-0.08}, -- Place Blight on #8
	["SwedenTownLv6_8"] = {1.24,0.1,-0.01}, -- Place Town on #8
    -- 9

    -- 10
    ["Beasts_10"] = {1.49,0.1,0.72},
	["FrancePlacement1_10"] = {1.11,0.1,0.77}, -- Extra French Town on Highest # without a town (7)
}
themMapE = {
    -- 1
    ["Explorer_1"] = {0.65,0.1,-0.93},
	["ExtraPlacement1_1"] = {0.79,0.1,-0.66}, -- Extra City on #1
    -- 2
    ["Town_2"] = {1.04,0.1,-0.25},
    ["Strife_2"] = {1.04,0.1,-0.25},
    ["Disease_2"] = {0.9,0.1,0.01},
    ["Disease_22"] = {1.15,0.12,0.02},
	["ExtraPlacement2_2"] = {1.43,0.1,0.5}, -- Extra Town on #2
    -- 3
    ["Town_3"] = {1.3,0.1,0.82},
    ["Strife_3"] = {1.3,0.1,0.82},
    ["City_3"] = {1.53,0.1,0.82},
    ["Dahan_3"] = {0.84,0.1,1.01},
    ["Dahan_33"] = {1.03,0.1,1.04},
    ["Blight_3"] = {1.43,0.1,1.05},
    ["Disease_3"] = {1.66,0.1,0.98},
	["ExtraPlacement3_3"] = {0.61,0.1,0.83}, -- Extra Town on #3
    -- 4
    ["Explorer_4"] = {-0.07,0.1,0.24},
    ["Dahan_4"] = {0.21,0.1,0.24},
    ["Dahan_44"] = {0.41,0.1,0.36},
    ["Dahan_444"] = {0.61,0.1,0.48},
	["SwedenCityLv2_4"] = {-0.2,0.1,0.25}, -- Place City on #4
    -- 5

    -- 6

    -- 7

    -- 8
    ["Explorer_8"] = {-0.9,0.1,0.39},
	["SwedenBlightLv6_8"] = {-0.85,0.1,-0.97}, -- Place Blight on #8
	["SwedenTownLv6_8"] = {-0.57,0.1,-0.87}, -- Place Town on #8
    -- 9
    ["Dahan_9"] = {-0.73,0.1,-0.23},
    ["Dahan_99"] = {-0.46,0.1,-0.3},
    -- 10
    ["Dahan_10"] = {-1.71,0.1,-0.72},
    ["Dahan_1010"] = {-1.52,0.1,-0.84},
	["FrancePlacement1_10"] = {-1.45,0.1,-0.57}, -- Extra French Town on Highest # without a town (7)
}
----
CitiesGuid = {
    "5b73f4",
    "f5f505",
    "742f9c",
    "51bf13"
}
TownsGuid = {
    "7dae55",
    "d3f101",
    "00ab75",
    "8fdbbc"
}
function printPos(posTable)
	print (posTable[1]..","..posTable[2]..","..posTable[3])
end


function getMaps()
	local mapTiles = {}
	for i,obj in pairs(upCast(seaTile,1,0,0.9)) do
		if obj.name == "Custom_Token" then
			if obj.getName() == "A" or obj.getName() == "B" or obj.getName() == "C" or obj.getName() == "D" then
				table.insert(mapTiles,obj)
			end
		end
	end
	return mapTiles
end
function getThematicMaps()
	local mapTiles = {}
	for i,obj in pairs(upCast(seaTile,1,0,0.9)) do
		if obj.name == "Custom_Token" then
			if obj.getName() == "E" or obj.getName() == "W" or obj.getName() == "NE" or obj.getName() == "NW" then
				table.insert(mapTiles,obj)
			end
		end
	end
	return mapTiles
end

function MapPlaceCustom()
	for i,map in pairs(getMaps()) do
		map.setLock(true)
		map.interactable = false
		posMap = self.getVar("posMap"..map.getName())
		placeStuffCustom(posMap,map.getRotation().y,map.getPosition())
	end
end

function MapPlacen(mapPieces, posMapx, rotMapn)
	for z=1, mapPieces do
		if boardType == "Standard" then
	        temp = StandardMapBag.takeObject({
				position = vecSum(StandardMapBag.getPosition(),{0,-5,0}),
	        })
			temp.setRotation(rotMapn[z], false, true)
			temp.setPositionSmooth(posMapx[z], false, true)
			wt(0.5)
			temp.setLock(true)
	        if temp.getName() == "A" then
	            placeStuffn(posMapA,rotMapn[z][2],posMapx,z)
	        elseif temp.getName() == "B" then
	            placeStuffn(posMapB,rotMapn[z][2],posMapx,z)
	        elseif temp.getName() == "C" then
	            placeStuffn(posMapC,rotMapn[z][2],posMapx,z)
	        elseif temp.getName() == "D" then
	            placeStuffn(posMapD,rotMapn[z][2],posMapx,z)
	        end
			--temp.setName("")
            temp.interactable = false
			wt(0.5)
		else
	        temp = ThematicMapBag.takeObject({
				position = vecSum(ThematicMapBag.getPosition(),{0,-5,0}),
	        })
			temp.setRotation(rotMapn[z], false, true)
			temp.setPositionSmooth(posMapx[z], false, true)
			wt(0.5)
			temp.setLock(true)
	        if temp.getName() == "E" then
	            placeStuffnq(themMapE,rotMapn[z][2],posMapx,z,temp)
	        elseif temp.getName() == "W" then
	            placeStuffnq(themMapW,rotMapn[z][2],posMapx,z,temp)
	        elseif temp.getName() == "NE" then
	            placeStuffnq(themMapNE,rotMapn[z][2],posMapx,z,temp)
	        elseif temp.getName() == "NW" then
	            placeStuffnq(themMapNW,rotMapn[z][2],posMapx,z,temp)
	        end
			--temp.setName("")
            temp.interactable = false
			wt(0.5)
		end
	end
end
function rotate_point(cx,cy,angle,p)
    s = math.sin(math.rad(angle))
    c = math.cos(math.rad(angle))

    px = p[1] - cx
    py = p[3] - cy

    xnew = px * c - py * s
    ynew = px * s + py * c

    px = xnew + cx
    py = ynew + cy
    return {px,p[2],py}
end
function placeTrans(rotation,posMapn,number,basePos)
	return rotate_point(posMapn[number][1],posMapn[number][3],0-rotation,basePos)
end
function placeTransCustom(rotation,posMapn,basePos)
	return rotate_point(posMapn[1],posMapn[3],0-rotation,basePos)
end
function placeStuffnq(LetterNumber,rotation,posMapn,number,board)
	for i,v in pairs (LetterNumber) do
		wt(0.01)
		l = string.find(i,"_")
		i = string.sub(i,1,l-1)
		v = {0-v[1],v[2],v[3]}
		local pos = board.positionToWorld(v)
		local pos = {pos[1],pos[2],pos[3]}
		if i == "Dahan" then
	        dahanBag.takeObject({
	            position       = pos,
	        })
		elseif i == "Town" then
			townBag.takeObject({
				position       = pos,
			})
		elseif i == "City" then
			cityBag.takeObject({
				position       = pos,
			})
		elseif i == "Explorer" then
			explorerBag.takeObject({
				position       = pos,
			})
		end
		if adversaryName == "Sweden" and adversaryLevel >= 2 then
			if i == "SwedenBlightLv2" then
				c = blightBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			elseif i == "SwedenCityLv2" then
				c = cityBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
		end
		if adversaryName == "Sweden" and adversaryLevel >= 6 then
			if i == "SwedenBlightLv6" then
				c = blightBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			elseif i == "SwedenTownLv6" then
				c = townBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
		end
		if i == "Blight" then
			blightBag.takeObject({
				position       = pos,
			})
		end
		if adversaryName == "England" and adversaryLevel >= 2 then
			if i == "ExtraPlacement1" then
				c = cityBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			elseif i == "ExtraPlacement2" then
				c = townBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
		end
		if adversaryName == "Brandenburg-Prussia" and adversaryLevel >= 1 then
			if i == "ExtraPlacement3" then
				c = townBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
		end
		if adversaryName == "France" and adversaryLevel >= 3 then
			if i == "ExtraPlacement1" then
				c = townBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
			if i == "FrancePlacement1" then
				c = townBag.takeObject({
					position       = pos,
				})
				c.highlightOn({1,1,1},60)
			end
		end
		if expansionsAdded then
			if i == "Disease" then
				diseaseBag.takeObject({
					position       = pos,
					rotation = {0,180,0}
				})
			elseif i == "Beasts" then
				beastsBag.takeObject({
					position       = pos,
					rotation = {0,180,0}
				})
			elseif i == "Strife" then
				strifeBag.takeObject({
					position       = vecSum(pos,{0,2,0}),
					rotation = {0,180,0}
				})
			elseif i == "Wilds" then
				wildsBag.takeObject({
					position       = pos,
					rotation = {0,180,0}
				})
			end
		end
	end
	return 1
end
function placeStuffCustom(LetterNumber,rotation,posMapn)
    for w=1, 6 do
        dahanBag.takeObject({
            position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["Dahan_" .. w])),
        })
    end
	townBag.takeObject({
		position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["Town"])),
	})
	cityBag.takeObject({
		position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["City"])),
	})
	if adversaryName == "Sweden" and adversaryLevel >= 2 then
		c = blightBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["SwedenBlightLv2"])),
		})
		c.highlightOn({1,1,1},60)
		c = cityBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["SwedenCityLv2"])),
		})
		c.highlightOn({1,1,1},60)
		if adversaryLevel >= 6 then
			c = blightBag.takeObject({
				position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["SwedenBlightLv6"])),
			})
			c.highlightOn({1,1,1},60)
			c = townBag.takeObject({
				position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["SwedenTownLv6"])),
			})
			c.highlightOn({1,1,1},60)
		end
	else
		blightBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["Blight"])),
		})
	end
	if adversaryName == "England" and adversaryLevel >= 2 then
		c = cityBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["ExtraPlacement1"])),
		})
		c.highlightOn({1,1,1},60)
		c = townBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["ExtraPlacement2"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if adversaryName == "Brandenburg-Prussia" then
		c = townBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["ExtraPlacement3"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if adversaryName == "France" and adversaryLevel >= 3 then
		c = townBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["ExtraPlacement1"])),
		})
		c.highlightOn({1,1,1},60)
		c = townBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["FrancePlacement1"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if expansionsAdded then
		diseaseBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["Disease"])),
			rotation = {0,180,0}
		})
		beastsBag.takeObject({
			position       = placeTransCustom(rotation,posMapn,vecSum(posMapn,LetterNumber["Beasts"])),
			rotation = {0,180,0}
		})
	end
	return 1
end
function placeStuffn(LetterNumber,rotation,posMapn,number)
    for w=1, 6 do
        dahanBag.takeObject({
            position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["Dahan_" .. w])),
        })
    end
	townBag.takeObject({
		position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["Town"])),
	})
	cityBag.takeObject({
		position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["City"])),
	})
	if adversaryName == "Sweden" and adversaryLevel >= 2 then
		c = blightBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["SwedenBlightLv2"])),
		})
		c.highlightOn({1,1,1},60)
		c = cityBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["SwedenCityLv2"])),
		})
		c.highlightOn({1,1,1},60)
		if adversaryLevel >= 6 then
			c = blightBag.takeObject({
				position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["SwedenBlightLv6"])),
			})
			c.highlightOn({1,1,1},60)
			c = townBag.takeObject({
				position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["SwedenTownLv6"])),
			})
			c.highlightOn({1,1,1},60)
		end
	else
		blightBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["Blight"])),
		})
	end
	if adversaryName == "England" and adversaryLevel >= 2 then
		c = cityBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["ExtraPlacement1"])),
		})
		c.highlightOn({1,1,1},60)
		c = townBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["ExtraPlacement2"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if adversaryName == "Brandenburg-Prussia" then
		c = townBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["ExtraPlacement3"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if adversaryName == "France" and adversaryLevel >= 3 then
		c = townBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["ExtraPlacement1"])),
		})
		c.highlightOn({1,1,1},60)
		c = townBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["FrancePlacement1"])),
		})
		c.highlightOn({1,1,1},60)
	end
	if expansionsAdded then
		diseaseBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["Disease"])),
			rotation = {0,180,0}
		})
		beastsBag.takeObject({
			position       = placeTrans(rotation,posMapn,number,vecSum(posMapn[number],LetterNumber["Beasts"])),
			rotation = {0,180,0}
		})
	end
	return 1
end

function onObjectDrop(player_color, dropped_object)
	if gameStarted > 0 then
		if dropped_object.getVar("highlightOnObjectDrop") ~= nil then
			if dropped_object.getVar("highlightOnObjectDrop") == true then
				dropColor = player_color
				if player_color == "Blue" then
					dropColor = {0.118, 0.53, 1}
				elseif player_color == "Red" then
					dropColor = {0.856, 0.1, 0.094}
				elseif player_color == "Yellow" then
					dropColor = {0.905, 0.898, 0.172}
				elseif player_color == "Purple" then
					dropColor = {0.627, 0.125, 0.941}
				end
				dropped_object.highlightOn(dropColor, 60)
			end
		end
	end
end

function DropMiniature(xPlayer,PlayerColored)
    if playerColorDrop == PlayerColored then
		dropColor = PlayerColored
		if PlayerColored == "Blue" then
			dropColor = {0.118, 0.53, 1}
		elseif PlayerColored == "Red" then
			dropColor = {0.856, 0.1, 0.094}
		elseif PlayerColored == "Yellow" then
			dropColor = {0.905, 0.898, 0.172}
		elseif PlayerColored == "Purple" then
			dropColor = {0.627, 0.125, 0.941}
		end
        if index1 == 1 then
            local temp = explorerBag.takeObject({
                position       = vecSum(xPlayer,{0,2,0})
            })
            temp.highlightOn(dropColor, 20)
        elseif index1 == 2 then
			if #townBag.getObjects() == 0 then
				broadcastToAll("There are no towns left to place", {1,0,0})
				if adversaryName == "France" then
					broadcastToAll("France wins via Additional Loss Condition!", {1,0,0})
				end
				return
			end
            local temp = townBag.takeObject({
                position       = vecSum(xPlayer,{0,2,0})
            })
            temp.highlightOn(dropColor, 20)
        elseif index1 == 3 then
            local temp = cityBag.takeObject({
                position       = vecSum(xPlayer,{0,2,0})
            })
            temp.highlightOn(dropColor, 20)
        elseif index1 == 4 then
			blightBagContents = blightBag.getObjects()
			if #blightBagContents == 0 then
				return
			end
            local temp = blightBag.takeObject({
                position       = vecSum(xPlayer,{0,2,0})
            })
            temp.highlightOn(dropColor, 20)
			if #blightBagContents == 0 then
			    broadcastToAll("The Island is BLIGHTED! - Flip the Healthy Island card", {1,0,0})
			end
        elseif index1 == 10 then
            local temp = dahanBag.takeObject({
                position       = vecSum(xPlayer,{0,2,0})
            })
            temp.highlightOn(dropColor, 20)
		elseif index1 == 6 then
			local temp = strifeBag.takeObject({
				position       = vecSum(xPlayer,{0,2,0}),
				rotation = {0,180,0}
			})
			temp.highlightOn(dropColor, 20)
		elseif index1 == 7 then
			local temp = beastsBag.takeObject({
				position       = vecSum(xPlayer,{0,2,0}),
				rotation = {0,180,0}
			})
			temp.highlightOn(dropColor, 20)
		elseif index1 == 8 then
			local temp = wildsBag.takeObject({
				position       = vecSum(xPlayer,{0,2,0}),
				rotation = {0,180,0}
			})
			temp.highlightOn(dropColor, 20)
		elseif index1 == 9 then
			local temp = diseaseBag.takeObject({
				position       = vecSum(xPlayer,{0,2,0}),
				rotation = {0,180,0}
			})
			temp.highlightOn(dropColor, 20)
	    end
	end
end

zoneDestroyTimer = 0
zoneDestroyFlag = false
function zoneDestroyTimerCoro()
	while 1 == 1 do
		if zoneDestroyTimer <= 10 then
			zoneDestroyTimer = zoneDestroyTimer + 1
			wt(0.1)
		else
			zoneDestroyTimer = 0
			if zoneDestroyFlag == true then
				startLuaCoroutine(Global, "checkZoneDestroy")
			end
		end
	end
	return 1
end

function checkZoneDestroy()
	enter_objects = getObjectFromGUID("ac4fad").getObjects()
	zoneDestroyFlag = false
	for i,enter_object1 in ipairs(enter_objects) do
        log(string.match(enter_object1.getName(),"Town"))
	    if enter_object1.getName() == "Dahan" then
			enter_object1.setRotation({0,0,0})
			wt(0.05)
	        dahanBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Explorer" then
			enter_object1.setRotation({0.00, 180.00, 0.00})
			wt(0.05)
	        explorerBag.putObject(enter_object1)
			wt(0.05)
	    elseif string.match(enter_object1.getName(),"Town") then
			if enter_object1.getStateId() ~= 1 then enter_object1 = enter_object1.setState(1) end
			enter_object1.setRotation({0.00, 270.00, 0.00})
			wt(0.05)
			townBag.putObject(enter_object1)
			wt(0.05)
	    elseif string.match(enter_object1.getName(),"City") then
			if enter_object1.getStateId() ~= 1 then enter_object1 = enter_object1.setState(1) end
			enter_object1.setRotation({0.00, 180.00, 0.00})
			wt(0.05)
			cityBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Blight" then
			enter_object1.setRotation({0,0,0})
			wt(0.05)
	        enter_object1.setPositionSmooth({blightBag.getPosition().x, blightBag.getPosition().y+0.5, blightBag.getPosition().z})
			wt(0.05)
	    elseif enter_object1.getName() == "Strife" then
			enter_object1.setRotation({0,180.00,0})
			wt(0.05)
			strifeBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Beasts" then
			enter_object1.setRotation({0,180.00,0})
			wt(0.05)
			beastsBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Wilds" then
			enter_object1.setRotation({0,180.00,0})
			wt(0.05)
			wildsBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Disease" then
			enter_object1.setRotation({0,180.00,0})
			wt(0.05)
			diseaseBag.putObject(enter_object1)
			wt(0.05)
	    elseif enter_object1.getName() == "Isolate" then
			enter_object1.setRotation({0,180.00,0})
			wt(0.05)
			isolateBag.putObject(enter_object1)
			wt(0.05)
		elseif enter_object1.getVar("destroyOnTableDrop") ~= nil then
			if enter_object1.getVar("destroyOnTableDrop") == true then
				destroyObject(enter_object1)
				wt(0.1)
			end
	    end
	end
    return 1
end
function onObjectEnterScriptingZone(zone, enter_object)
    if gameStart == true then
        if zone.guid == "ac4fad" then
            if enter_object.tag != "Card" then
				zoneDestroyFlag = true
            end
        end
    end
end
---
placeObjectDelay = false
function onScriptingButtonDown(index, playerColor)
	if gameStart == false then
		return
	end
	if placeObjectDelay == true then
		--return
	end
    placeObjectDelay = true
    index1 = index
    playerColorDrop = playerColor
    DropMiniature(Player.Red.getPointerPosition() ,"Red")
    DropMiniature(Player.Purple.getPointerPosition(),"Purple")
    DropMiniature(Player.Blue.getPointerPosition(),"Blue")
    DropMiniature(Player.Yellow.getPointerPosition(),"Yellow")
    DropMiniature(Player.Green.getPointerPosition(),"Green")
    DropMiniature(Player.Orange.getPointerPosition(),"Orange")
	startLuaCoroutine(Global, "placeObjectDelayFunc")
end
function placeObjectDelayFunc()
	wt(0.2)
	placeObjectDelay = false
	return 1
end
-----
function vecSum(vec1,vec2)
    return {vec1[1]+vec2[1], vec1[2]+vec2[2],  vec1[3]+vec2[3]}
end
function Vec_sub(vec1,vec2)
    return {vec1[1]-vec2[1], vec1[2]-vec2[2],  vec1[3]-vec2[3]}
end
---------------
function wt(some)
local Time = os.clock() + some
        while os.clock() < Time do
            coroutine.yield(0)
        end
end
--------------------
function upCast(obj,dist,offset,multi)
    local dist = dist or 1
    local offset = offset or 0
    local multi = multi or 1
    local oPos = obj.getPosition()
    local oBounds = obj.getBoundsNormalized()
    local oRot = obj.getRotation()
    local orig = {oPos[1],oPos[2]+offset,oPos[3]}
    local siz = {oBounds.size.x*multi,dist,oBounds.size.z*multi}
    local orient = {oRot[1],oRot[2],oRot[3]}
    local hits = Physics.cast({
        origin       = orig,
        direction    = {0,1,0},
        type         = 3,
        size         = siz,
        orientation  = orient,
        max_distance = 0,
        --debug        = true,
    })
    local hitObjects = {}
    for i,v in pairs(hits) do
        if v.hit_object ~= obj then table.insert(hitObjects,v.hit_object) end
    end
    return hitObjects
end
function upCastPosSizRot(oPos,size,rot,dist,multi,tags)
	local rot = rot or {0,0,0}
    local dist = dist or 1
    local offset = offset or 0
    local multi = multi or 1
	local tags = tags or {}
    local oBounds = size
    local oRot = rot
    local orig = {oPos[1],oPos[2],oPos[3]}
    local siz = {oBounds[1]*multi,dist,oBounds[3]*multi}
    local orient = {oRot[1],oRot[2],oRot[3]}
    local hits = Physics.cast({
        origin       = orig,
        direction    = {0,1,0},
        type         = 3,
        size         = siz,
        orientation  = orient,
        max_distance = 0,
        ----debug        = true,
    })
    local hitObjects = {}
    for i,v in pairs(hits) do
		if v.hit_object ~= obj then
			if tags ~= {} then
				matchesTag = false
				for _,t in pairs(tags) do
					if v.hit_object.tag == t then matchesTag = true end
				end
				if matchesTag then
					table.insert(hitObjects,v.hit_object)
				end
			else
        		table.insert(hitObjects,v.hit_object)
			end
		end
    end
    return hitObjects
end
