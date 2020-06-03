function onLoad()
    self.createButton({
        click_function = "setupHero",
        function_owner = self,
        label          = "Choose Hero",
        position       = {0, -0.1, 1.1},
        rotation       = {0,0,180},
        scale = {0.2, 0.2, 0.2},
        width          = 1800,
        height         = 500,
        font_size      = 300,
    })
end

function specificHeroSetup(object_picker, player_color)
    success = false
    params = {
        hero = Global.getVar('boards')[],
        player_color = player_color
        }
        Global.call('SetupHero',params)
    print(success)

end
function setupHero (object_picker, player_color)

    --Board setup
    local hpos = Player[player_color].getHandTransform().position
    local hforward = Player[player_color].getHandTransform().forward
    local hrot = Player[player_color].getHandTransform().rotation
        self.setPosition({hpos.x,1,hpos.z+(12*hforward.z)})
        self.setRotation({hrot.x+180, hrot.y, hrot.z})

    -- Starting Hand setup
    local hand = getObjectFromGUID(Global.getVar('hands')['arien'])
    hand.deal(5,player_color)

    -- Improved Cards setup
    deck = getObjectFromGUID(Global.getVar('decks')['arien'])

    local deckHdisp = hpos.x - 3.5
    local deckVdisp = hpos.z + (7.1*hforward.z)
    cardTable = {
            position = {deckHdisp, 0.5, deckVdisp},
            rotation = {hrot.x+180,hrot.y,hrot.z},
            flip = true,
            smooth = true
            }

    -- Deals Improved Cards below board
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
    return True
end