local addonName, addon = ...
addon.compat = {}

local GetMouseFocus = function(...)
  if _G.GetMouseFoci then
    return _G.GetMouseFoci(...)[1]
  elseif _G.GetMouseFocus then
    return _G.GetMouseFocus(...)
  end
end
local LocalizedClassList = function(...)
  if _G.LocalizedClassList then
    return _G.LocalizedClassList(...)
  elseif _G.FillLocalizedClassList then
    local t = {}
    return _G.FillLocalizedClassList(t,...)
  end
end
local SendChatMessage = function(...)
  if C_ChatInfo and C_ChatInfo.SendChatMessage then
    return C_ChatInfo.SendChatMessage(...)
  elseif _G.SendChatMessage then
    return _G.SendChatMessage(...)
  end
end

local compat = addon.compat
compat.GetMouseFocus = GetMouseFocus
compat.LocalizedClassList = LocalizedClassList
compat.SendChatMessage = SendChatMessage