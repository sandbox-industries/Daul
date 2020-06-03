handGUIDs = {
    ['Arien'] = '76cc04',
    ['Bain'] = '320c14',
    ['Brogan'] = '0459f8',
    ['Cutter'] = 'bbae4f',
    ['Dodger'] = 'b44b2c',
    ['Garrus'] = 'e5699a',
    ['Hanu'] = 'cf225a',
    ['Ignatia'] = '44d125',
    ['Misa'] = 'c96749',
    ['Min'] = '20e38a',
    ['Nebkher'] = 'b91f8e',
    ['Sabina'] = '0800c9',
    ['Silverarrow'] = '95903d',
    ['Swift'] = 'fb474c',
    ['Tali'] = 'bcbf04',
    ['Tigerclaw'] = '19c600',
    ['Trinkets'] = '6e8a82',
    ['Ursafar'] = 'af99a0',
    ['Wasp'] = '3853fc',
    ['Whisper'] = '1f392b',
    ['Wuk'] = '8494d8',
    ['Xargatha'] = 'b1f7dd'
}

boardGUIDs = {
    ['Arien'] = '2357b1',
    ['Bain'] = '0647da',
    ['Brogan'] = '26b42a',
    ['Cutter'] = '72fa36',
    ['Dodger'] = 'c21581',
    ['Garrus'] = '73d133',
    ['Hanu'] = 'e40716',
    ['Ignatia'] = '8af4d5',
    ['Misa'] = '1d7b9d',
    ['Min'] = '755274',
    ['Nebkher'] = '41c71c',
    ['Sabina'] = '04292d',
    ['Silverarrow'] = '42a72b',
    ['Swift'] = '00637e',
    ['Tali'] = '2d604a',
    ['Tigerclaw'] = '4b6c8c',
    ['Trinkets'] = '4080b2',
    ['Ursafar'] = '726f9d',
    ['Wasp'] = '302ac2',
    ['Whisper'] = '7bd2a9',
    ['Wuk'] = 'd70c1f',
    ['Xargatha'] = '23ba05'
}

deckGUIDs = {
    ['Arien'] = 'efb00f',
    ['Bain'] = 'a1db9a',
    ['Brogan'] = '79dade',
    ['Cutter'] = '21f4e6',
    ['Dodger'] = 'cc618f',
    ['Garrus'] = 'c5768b',
    ['Hanu'] = '937e20',
    ['Ignatia'] = '503815',
    ['Misa'] = 'b6e375',
    ['Min'] = 'b37f46',
    ['Nebkher'] = '67c686',
    ['Sabina'] = '1088a3',
    ['Silverarrow'] = '5c038d',
    ['Swift'] = '5e8156',
    ['Tali'] = 'a6368b',
    ['Tigerclaw'] = '6d5a4c',
    ['Trinkets'] = 'ce47c6',
    ['Ursafar'] = '7f7158',
    ['Wasp'] = '1f6cca',
    ['Whisper'] = '3aa17e',
    ['Wuk'] = 'b360b3',
    ['Xargatha'] = '92948b'
}

figureGUIDs = {
    ['Arien'] = '53d8ae',
    ['Bain'] = '4d38a0',
    ['Brogan'] = '458861',
    ['Cutter'] = '64a391',
    ['Dodger'] = 'a43eaa',
    ['Garrus'] = '412647',
    ['Hanu'] = '172995',
    ['Ignatia'] = '9aeba4',
    ['Misa'] = 'a3a354',
    ['Min'] = '3dafa4',
    ['Nebkher'] = '415b02',
    ['Sabina'] = '7fdd3d',
    ['Silverarrow'] = 'd43112',
    ['Swift'] = 'e314de',
    ['Tali'] = '579b67',
    ['Tigerclaw'] = '9feb00',
    ['Trinkets'] = '009bb1',
    ['Ursafar'] = 'a0d472',
    ['Wasp'] = 'bbb4aa',
    ['Whisper'] = '7ef181',
    ['Wuk'] = 'e5ed85',
    ['Xargatha'] = '687df1'
}

tokenGUIDs = {
    ['Arien'] = nil,
    ['Bain'] = '2f42fd',
    ['Brogan'] = nil,
    ['Cutter'] = '5d187b',
    ['Dodger'] = nil,
    ['Garrus'] = nil,
    ['Hanu'] = nil,
    ['Ignatia'] = 'edcf6a',
    ['Misa'] = nil,
    ['Min'] = 'be3133',
    ['Nebkher'] = '08e2ea',
    ['Sabina'] = nil,
    ['Silverarrow'] = nil,
    ['Swift'] = nil,
    ['Tali'] = '3fff6f',
    ['Tigerclaw'] = 'b7d789',
    ['Trinkets'] = '64803e',
    ['Ursafar'] = nil,
    ['Wasp'] = nil,
    ['Whisper'] = nil,
    ['Wuk'] = '3c5128',
    ['Xargatha'] = '8dd2d3'
}
minionGUIDs = {
    ['r1'] = '0ab424',
    ['r2'] = 'dfdbd4',
    ['r3'] = 'bb3058',
    ['r4'] = '62646e',
    ['rr'] = '25b845',
    ['rH'] = 'b67159',
    ['b1'] = 'f170b4',
    ['b2'] = '0be7b9',
    ['b3'] = '841f1f',
    ['b4'] = 'dcb9d6',
    ['br'] = '90b17b',
    ['bH'] = '240ae9'
}

minionPositions = {
    ['r1'] = {0, 0, 0},
    ['r2'] = {0, 0, 0},
    ['r3'] = {0, 0, 0},
    ['r4'] = {0, 0, 0},
    ['rr'] = {0, 0, 0},
    ['rH'] = {0, 0, 0},
    ['b1'] = {0, 0, 0},
    ['b2'] = {0, 0, 0},
    ['b3'] = {0, 0, 0},
    ['b4'] = {0, 0, 0},
    ['br'] = {0, 0, 0},
    ['bH'] = {0, 0, 0},
}

-- Misc GUIDs
mainBoard_GUID = 'a09bf4'
initiativeCoin_GUID = '4312b3'
pushTracker_GUID = 'ac7751'
redSpawn_GUID = 'ee137d'
blueSpawn_GUID = 'd6a42f'

function onload()
    mainBoard = getObjectFromGUID(mainBoard_GUID)
    mainBoard.createButton({
        click_function = "pcButton",
        label          = "2v2",
        position       = {0, 0.2, -17},
        width = 1400,
        height = 600,
        font_size = 400,
    })
    mainBoard.createButton({
        click_function = "gameLength",
        label          = "Short Game",
        position       = {0, 0.2, -15},
        width = 1400,
        height = 400,
        font_size = 250,
    })
    mainBoard.createButton({
        click_function = "start",
        label          = "Start",
        position       = {0, 0.2, -13},
        width = 1500,
        height = 750,
        font_size = 500,
        color = {0, 1, 0}
    })
end


-- Player Count Button. Toggles between 2v2 and 3v3
playerCount = 2
function pcButton()
    if playerCount == 2 then
        playerCount = 3
    elseif playerCount == 3 then
        playerCount = 2
    end
    mainBoard.editButton(
        {
            index = 0,
            label = playerCount .. " vs " .. playerCount
        }
    )
end

-- Game length button. Toggles between "Short" and "Long"
desiredLength = "Short"
function gameLength()
    if desiredLength == "Short" then
        desiredLength = "Long"
    elseif desiredLength == "Long" then
        desiredLength = "Short"
    end
    mainBoard.editButton(
        {
            index = 1,
            label = desiredLength .. " Game"
        }
    )
end

-- Start button. Sets up game once pressed
function start()
    initiativeCoin = getObjectFromGUID(initiativeCoin_GUID)
    pushTracker = getObjectFromGUID(pushTracker_GUID)
    redSpawn = getObjectFromGUID(redSpawn_GUID)
    blueSpawn = getObjectFromGUID(blueSpawn_GUID)

    -- 50% chance of initiative coin flipping.
    local coinFlip = math.random(0,1)
    if coinFlip == 0 then
        initiativeCoin.flip()
    end
    broadcastToAll("Initiative Coin Randomized!", "Pink")

    -- Team randomization based on player count
    randBag = spawnObject(
            {
                type = "Bag",
                position = {0, 1, 18},
                callback_function  = function(obj) spawn_callback(obj, "Team Randomizer", "Purple") end
            }
    )
    for i = 1, playerCount do
        redSpawn.clone(
                {
                    position = {0, 2.5+(i*0.5), 18}
                }
        )
        blueSpawn.clone(
                {
                    position = {0, 2.5+(i*0.5), 18}
                }
        )
    end
    Wait.frames(function() randBag.shuffle() end, 60)
    Wait.frames(function() randBag.deal(1) end, 90)
    Wait.frames(function() randBag.setLock(true) end, 120)
    -- Wait.frames(function() randBag.destruct() end, 120)

    -- Push trackers and spawn tokens based on game length
    if desiredLength == "Short" then
        pushCopies = 3
        spawnCopies = 4
    elseif desiredLength == "Long" then
        pushCopies = 5
        spawnCopies = 8
    end
    -- Push trackers

    for i = 2, pushCopies do
        pushTracker.clone(
                {
                    position = pushTracker.getPosition()
                }
        )
    end

    -- Spawn tokens
    for i = 2, spawnCopies do
        redSpawn.clone(
                {
                    position = redSpawn.getPosition()
                }
        )
        blueSpawn.clone(
                {
                    position = blueSpawn.getPosition()
                }
        )
    end

    -- Board button creation
    for hero, guid in pairs(boardGUIDs) do
        local heroBoard = getObjectFromGUID(guid)
        heroBoard.createButton({
            click_function = "setupHero",
            label          = "Choose Hero",
            position       = {0, 0.1, 1.2},
            rotation       = {0,0,180},
            width          = 600,
            height         = 200,
            font_size      = 100,
            tooltip        = "Choose " .. hero
        })

    end

    -- Delete buttons
    for i = 0,2 do
        mainBoard.removeButton(i)
    end

    -- Create push buttons
    mainBoard.createButton({
        click_function = "redPush",
        label          = "Red Push",
        position       = {-7, 0.2, -10},
        width          = 1500,
        height         = 750,
        font_size      = 300,
        font_color     = {1, 0, 0},
        tooltip        = 'Red Push'
    })
    mainBoard.createButton({
        click_function = "bluePush",
        label          = "Blue Push",
        position       = {7, 0.2, 10},
        rotation       = {0, 180, 0},
        width          = 1500,
        height         = 750,
        font_size      = 300,
        font_color     = {0, 0, 1},
        tooltip        = 'Blue Push'
    })
end

function setupHero(board, player_color)
    --Obtaining hero ID
    local hero = board.getName()

    --Board setup
    local hpos = Player[player_color].getHandTransform().position
    local hforward = Player[player_color].getHandTransform().forward
    local hrot = Player[player_color].getHandTransform().rotation
    board.setPosition({hpos.x,1,hpos.z+(12*hforward.z)})
    board.setRotation({hrot.x+180, hrot.y, hrot.z})
    board.setLock(true)

    -- Figure setup
    local figure = getObjectFromGUID(figureGUIDs[hero])
    figure.setPosition({hpos.x,1,hpos.z+(15.6*hforward.z)})

    -- Tokens setup
    local tokens = getObjectFromGUID(tokenGUIDs[hero])
    if tokens ~= nil then
        tokens.setPosition({hpos.x+2,1,hpos.z+(15.6*hforward.z)})
    end

    -- Starting Hand setup
    local hand = getObjectFromGUID(handGUIDs[hero])
    for i = 1, 5 do
        hand.takeObject({
            position = hpos,
            rotation = {hrot.x+180,hrot.y,hrot.z},
            flip = true,
            smooth = false
        })
    end

    -- Improved Cards setup
    local deck = getObjectFromGUID(deckGUIDs[hero])
    local deckHdisp = hpos.x - 3.5
    local deckVdisp = hpos.z + (7.1*hforward.z)
    cardTable = {
            position = {deckHdisp, 2, deckVdisp},
            rotation = {hrot.x+180,hrot.y,hrot.z},
            flip = true,
            smooth = false
            }
    for j = 1, 3 do
        for i=1, 2 do
            deck.takeObject(cardTable)
            cardTable.position[3] = cardTable.position[3] - (3.1*hforward.z)
            deck.takeObject(cardTable)
            cardTable.position[3] = cardTable.position[3] + (3.1*hforward.z)
            cardTable.position[2] = cardTable.position[2]+1
        end
        cardTable.position[2] = cardTable.position[2]-2
        cardTable.position[1] = cardTable.position[1]+3
    end
    cardTable.position[3] = cardTable.position[3] - (1.55*hforward.z)
    deck.takeObject(cardTable)

    -- Delete button
    board.removeButton(0)

    broadcastToAll(player_color .. " chose " .. hero)
end

-- Minion pushing
function minionPush()

    recordMinionPosition()

    if pushState == 0 then

        for minionName, guid in pairs(minionGUIDs) do
            local minion = getObjectFromGUID(guid)
            minion.setPosition(minionsAtCenter[minionName])
        end
    elseif pushState == 1 then
        for minionName, guid in pairs(minionGUIDs) do
            local minion = getObjectFromGUID(guid)
            minion.setPosition(minionsAtRed[minionName])
        end
    elseif pushState == -1 then
        for minionName, guid in pairs(minionGUIDs) do
            local minion = getObjectFromGUID(guid)
            minion.setPosition(minionsAtBlue[minionName])
        end
    elseif pushState > 1 then
        broadcastToAll("Blue Team Wins!", {0, 0, 1})
        state = 1
    elseif pushState < -1 then
        broadcastToAll("Red Team Wins!", {1, 0, 0})
        state = -1
    end
    local ptStack = getObjectFromGUID(pushTracker_GUID)
    ptStack.takeObject({
            position = {22, 2, 0}
    })
end

-- pushState 1 is pushed into red
-- pushState 0 is pushed into center
-- pushState -1 is pushed into blue

pushState = 0

function redPush(mainBoard)

    if btnCounter(mainBoard) == 3 then

        mainboard.removeButton(2)

        mainBoard.createButton({
            click_function = "undoPush",
            label          = "Undo",
            position       = {-7, 0.2, -13},
            width          = 1000,
            height         = 500,
            font_size      = 150,
            font_color     = {1, 1, 1},
            color          = {1, 0.3, 1},
            tooltip        = 'Undoes Previous Push'
            })

    end

    pushState = pushState - 1
    minionPush()

end

function bluePush(mainBoard, alt_click)

    if btnCounter(mainBoard) == 3 then

        mainboard.removeButton(2)

        mainBoard.createButton({
            click_function = "undoPush",
            label          = "Undo",
            position       = {7, 0.2, 13},
            rotation       = {0, 180, 0},
            width          = 1000,
            height         = 500,
            font_size      = 150,
            font_color     = {1, 1, 1},
            color          = {0, 1, 1},
            tooltip        = 'Undoes Previous Push'
        })
    end

    pushState = pushState + 1
    minionPush()
end

function recordMinionPosition()

    for minion, pos in pairs(minionPositions) do

        minionPositions[minion] = getObjectFromGUID(minionGUIDs[minion]).getPosition()

    end
end

function undoPush(mainBoard)

    -- sets each minion to their positions prior to the previous push
    for minion, pos in pairs(minionPositions) do

        local minionObj = getObjectFromGUID(minionGUIDs[minion])
        minionObj.setPosition(pos)

    end

    mainBoard.removeButton(2)

    broadcastToAll('Minion Push Undone')

end

function btnCounter(obj)

    local btnCount = #obj.getButtons()
    return btnCount

end

minionsAtCenter ={
    ['r1'] = {3.277421, 2.9, -0.00693},
    ['r2'] = {-0.070543, 2.9, 2.188111},
    ['r3'] = {-2.104582, 2.9, 0.08614},
    ['r4'] = {-3.775436, 2.9, 5.942632},
    ['rr'] = {4.334873, 2.9, 1.053704},
    ['rH'] = {-5.494975, 2.9, 2.348605},
    ['b1'] = {-5.117729, 2.9, 0.878889},
    ['b2'] = {-1.810353, 2.9, -1.370653},
    ['b3'] = {0.356198, 2.9, 0.787527},
    ['b4'] = {1.933507, 2.9, -5.071449},
    ['br'] = {-6.196518, 2.9, -0.185983},
    ['bH'] = {3.666024, 2.9, -1.469351},
}

minionsAtBlue ={
    ['r1'] = {2.692342, 2.9, -7.996668},
    ['r2'] = {0.15169, 2.9, -8.693028},
    ['r3'] = {-3.157513, 2.9, -6.43907},
    ['r4'] = {20, 2, 0},
    ['rr'] = {-0.624931, 2.9, -5.760215},
    ['rH'] = {-1.32924, 2.9, -8.299257},
    ['b1'] = {-4.607807, 2.9, -6.03714},
    ['b2'] = {-4.23162, 2.9, -7.503554},
    ['b3'] = {-4.505794, 2.9, -11.490488},
    ['b4'] = {3.068532, 2.9, -9.463082},
    ['br'] = {-0.911221, 2.9, -9.759264},
    ['bH'] = {-2.361517, 2.9, -9.357333},
}

minionsAtRed = {
    ['r1'] = {2.763439, 2.9, 6.904412},
    ['r2'] = {2.380502, 2.9, 8.357696},
    ['r3'] = {2.673337, 2.9, 12.359196},
    ['r4'] = {-4.94849, 2.9, 10.31721},
    ['rr'] = {-0.953795, 2.9, 10.625224},
    ['rH'] = {0.519859, 2.9, 10.237421},
    ['b1'] = {-4.565549, 2.9, 8.863928},
    ['b2'] = {-2.024377, 2.9, 9.541198},
    ['b3'] = {1.313142, 2.9, 7.306343},
    ['b4'] = {20, 2, 0},
    ['br'] = {-1.245748, 2.9, 6.621891},
    ['bH'] = {-0.550723, 2.9, 9.153391},
}

-- Callback function. Allows spawned objects to be manipulated.
function spawn_callback(object_spawned, name, color)
    object_spawned.setName(name)
    object_spawned.setColorTint(color)
end