-- This is the tutorial: basic combat.

-- localization stuff, translators would work here
lang = naev.lang()
if lang == "es" then
else -- default english
    title1 = "Tutorial: Basic combat"
    message1 = [[Welcome to tutorial: Basic combat.

Combat is an important aspect of Naev, and you will have to fight off enemies sooner or later, no matter what career you decide to pursue. In this tutorial, you will learn the basic principles of combat.]]
    message2 = [[For this tutorial, you will be flying a Lancelot fighter. It comes equipped with two advanced laser cannons. You can fire your weapons by pressing %s. Try this now.]]
    message3 = [[You may have noticed that as you fired your weapons, you depleted your energy gauge. Most energy weapons use energy while firing, and when you run out of energy you can no longer use them. Energy recharges automatically over time.

Now we will examine another type of weapon that uses ammunition instead of energy. Ammunition does not automatically recharge, you will have to buy it on planets or stations.

You have been equipped with a Mace rocket launcher. Fire it now using %s and watch its ammunition deplete.]]

    wepsomsg = [[Use %s to test your weapons (%ds remaining)]]
end

function create()
    misn.accept()
    
    -- Set up the player here.
    player.teleport("Iroquois")
    
    player.pilot():setPos(vec2.new(0, 0))
    -- TODO: switch to Lancelot. Equip with two Laser MK2s.

    enable = {"menu", "left", "right", "accel", "reverse", "primary"}
    enableKeys(enable)

    tkMsg(title1, message1, enable)
    tkMsg(title1, message2:format(tutGetKey("primary")), enable)
    omsg = player.omsgAdd(wepomsg:format(tutGetKey("primary"), flytime), 0)

    waitenergy = true
    flytime = 10 -- seconds of fly time
    hook.timer(1000, "flyUpdate")
end

-- Allow the player to fly around as he likes for 10s.
function flyUpdate()
    flytime = flytime - 1
    
    if waitenergy then 
        if flytime == 0 then
            waitenergy = false
            player.omsgRm(omsg)
            tkMsg(title1, message3:format(tutGetKey("primary")), enable)
            waitammo = true
            flytime = 10
            omsg = player.omsgAdd(wepomsg:format(tutGetKey("primary"), flytime), 0)
        else
            player.omsgChange(omsg, wepsomsg:format(tutGetKey("primary"), flytime), 0)
            hook.timer(1000, "flyUpdate")
        end
    elseif waitammo then
        if flytime == 0 then
            player.omsgRm(omsg)
            waitammo = false
        else
            player.omsgChange(omsg, wepsomsg:format(tutGetKey("primary"), flytime), 0)
            hook.timer(1000, "flyUpdate")
        end
    end
end

-- Input hook.
function input(inputname, inputpress)
end

-- Abort hook.
function abort()
    cleanup()
end

-- Cleanup function. Should be the exit point for the module in all cases.
function cleanup()
    -- Function to return to the tutorial menu here
end