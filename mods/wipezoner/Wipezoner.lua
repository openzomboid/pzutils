--
-- Copyright (c) 2022 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

Version = "0.1.0"

Wipezoner = {
    ISInventoryTransferAction = {
        Original = {
            perform = ISInventoryTransferAction.perform
        }
    },
    ISInventoryPaneContextMenu = {
        Top = "",
        Original = {
            onWriteSomething = ISInventoryPaneContextMenu.onWriteSomething,
            onWriteSomethingClick = ISInventoryPaneContextMenu.onWriteSomethingClick
        }
    }
}

-- getLogLinePrefix generates prefix for each log lines.
-- for ease of use, we assume that the player’s existence has been verified previously.
Wipezoner.getLogLinePrefix = function(player, action)
    -- TODO: Add ownerID.
    return getCurrentUserSteamID() .. " \"" .. player:getUsername() .. "\" " .. action
end

-- getLocation returns players or vehicle location in "x,x,z" format.
Wipezoner.getLocation = function(obj)
    return math.floor(obj:getX()) .. "," .. math.floor(obj:getY()) .. "," .. math.floor(obj:getZ());
end

Wipezoner.getTop = function(obj)
    local x = tostring(math.floor(obj:getX()))
    local y = tostring(math.floor(obj:getY()))

    return x:sub(1, -2) .. "0x" .. y:sub(1, -2) .. "0";
end

Wipezoner.getBottom = function(obj)
    local x = tostring(math.floor(obj:getX()))
    local y = tostring(math.floor(obj:getY()))

    return x:sub(1, -2) .. "9x" .. y:sub(1, -2) .. "9";
end

Wipezoner.ISInventoryTransferAction.perform = function(self)
    Wipezoner.ISInventoryTransferAction.Original.perform(self)

    local player = getSpecificPlayer(0);
    if not player then return end
end

Wipezoner.ISInventoryPaneContextMenu.onWriteSomething = function(notebook, editable, player)
    Wipezoner.ISInventoryPaneContextMenu.Original.onWriteSomething(notebook, editable, player)

    local name = notebook:getName();
    if name == "wipezone" then
        Wipezoner.ISInventoryPaneContextMenu.Top = Wipezoner.getTop(getSpecificPlayer(player))
    end
end

function Wipezoner.ISInventoryPaneContextMenu:onWriteSomethingClick(button)
    Wipezoner.ISInventoryPaneContextMenu.Original:onWriteSomethingClick(button)

    if button.internal == "OK" then
        local player = getSpecificPlayer(0);
        if not player then return end

        local notebook = button.parent.notebook

        local bookname = notebook:getName();
        if bookname == "wipezone" then
            local message = Wipezoner.getLogLinePrefix(player, "wipezone set");

            local text = notebook:seePage(1);
            local city = ""
            local name = ""
            city, name=text:match"([^.]*).(.*)"
            if city == "" or name == "" then
                player:Say("incorrect city or name");

                return
            end

            local top = Wipezoner.ISInventoryPaneContextMenu.Top
            local bottom = Wipezoner.getBottom(player)
            if top == "" or top == bottom then
                player:Say("incorrect top or bottom");

                return
            end

            message = message .. ' {'
                .. '"enable":true,'
                .. '"city":"' .. city .. '",'
                .. '"name":"' .. name .. '",'
                .. '"area":{"top":"' .. top .. '","bottom":"' .. bottom .. '"}'
            ..'}'

            local location = Wipezoner.getLocation(player);
            message = message .. " (" .. location .. ")"

            writeLog("pzlsm", message);
            player:Say("set wipezone success");
            Wipezoner.ISInventoryPaneContextMenu.Top = ""
        end
    end
end

ISInventoryTransferAction.perform = Wipezoner.ISInventoryTransferAction.perform;
ISInventoryPaneContextMenu.onWriteSomething = Wipezoner.ISInventoryPaneContextMenu.onWriteSomething;
ISInventoryPaneContextMenu.onWriteSomethingClick = Wipezoner.ISInventoryPaneContextMenu.onWriteSomethingClick;
