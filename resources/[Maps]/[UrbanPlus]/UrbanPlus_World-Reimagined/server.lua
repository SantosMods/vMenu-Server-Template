-- server.lua
-- UrbanPlus: World Reimagined — Bootstrap, manifest fetch, and startup banners
-- © 2025 SantosMods.dev. All rights reserved.

-- =========================
-- Configuration
-- =========================
local CURRENT_VERSION  = "v0.2.8-alpha"
local VERSION_URL_BASE = "https://raw.githubusercontent.com/SantosMods/UrbanPlus_World-Reimagined/refs/heads/main/version"
local SITE_URL         = "https://santosmods.dev"
local SUPPORT_URL      = "https://santosmods.dev/discord"

-- =========================
-- Runtime State
-- =========================
local latestVersion = "unknown"
local releaseStage  = "unknown"
local changelog     = "N/A"
local fileAmount    = "unknown"
local resourceName  = GetCurrentResourceName()

-- =========================
-- ANSI Colors
-- =========================
local C = {
    reset   = "\27[0m",
    white   = "\27[97m",
    green   = "\27[92m",
    yellow  = "\27[93m",
    red     = "\27[91m",
    cyan    = "\27[96m",
    gray    = "\27[90m",
    blue    = "\27[94m",
    magenta = "\27[95m",
}

-- =========================
-- Logging
-- =========================
local function ts() return os.date("!%Y-%m-%dT%H:%M:%SZ") end
local function log(color, lvl, msg) print(("%s[%s] [UrbanPlus] [%s] %s%s"):format(color, ts(), lvl, msg, C.reset)) end
local function info(m) log(C.white,  "INFO",  m) end
local function ok(m)   log(C.green,  "OK",    m) end
local function warn(m) log(C.yellow, "WARN",  m) end
local function err(m)  log(C.red,    "ERROR", m) end

local function centerText(text, width)
    width = width or 100
    local len = #text
    if len >= width then return text end
    local pad = math.floor((width - len) / 2)
    return string.rep(" ", pad) .. text
end

-- =========================
-- ASCII Banner (URBANPLUS - Banner Font)
-- =========================
local function asciiBanner()
    print(C.cyan .. [[
88        88              88                                    88888888ba   88                          
]] .. C.white .. [[
88        88              88                                    88      "8b  88                          
]] .. C.green .. [[
88        88              88                                    88      ,8P  88                          
]] .. C.yellow .. [[
88        88  8b,dPPYba,  88,dPPYba,   ,adPPYYba,  8b,dPPYba,   88aaaaaa8P'  88  88       88  ,adPPYba,  
]] .. C.red .. [[
88        88  88P'   "Y8  88P'    "8a  ""     `Y8  88P'   `"8a  88""""""'    88  88       88  I8[    ""  
]] .. C.magenta .. [[
88        88  88          88       d8  ,adPPPPP88  88       88  88           88  88       88   `"Y8ba,   
]] .. C.blue .. [[
Y8a.    .a8P  88          88b,   ,a8"  88,    ,88  88       88  88           88  "8a,   ,a88  aa    ]8I  
]] .. C.cyan .. [[
 `"Y8888Y"'   88          8Y"Ybbd8"'   `"8bbdP"Y8  88       88  88           88   `"YbbdP'Y8  `"YbbdP"'  
    ]] .. C.reset)
end

-- =========================
-- Main Banner
-- =========================
local function banner()
    print("") ; print("")
    print(C.blue  .. centerText("UrbanPlus: World Reimagined"))
    print(C.white .. centerText("Thank you for using SantosMods.dev") .. "\n")

    print(C.yellow .. centerText("Release Stage: " .. releaseStage))
    print(C.gray   .. centerText("Resource: " .. resourceName) .. "\n")

    print(C.green  .. centerText("Using Version: " .. CURRENT_VERSION))
    print(C.red    .. centerText("Latest Version: " .. latestVersion) .. "\n")

    print(C.white  .. centerText("CHANGELOG"))
    print(C.white  .. centerText("• " .. changelog) .. "\n")

    print(C.cyan   .. centerText("Website: " .. SITE_URL))
    print(C.gray   .. centerText("Support: " .. SUPPORT_URL) .. "\n")

    print(C.white  .. centerText("Content Files Reported: " .. tostring(fileAmount)))
    print(C.white  .. centerText("© 2025 SantosMods.dev — All Rights Reserved"))
    print(C.reset)
    print("") ; print("")
end

-- =========================
-- Manifest Fetch (always cache-busted)
-- =========================
local function buildCacheBustedURL()
    local salt = ("%d-%04d"):format(os.time(), math.random(1000, 9999))
    return VERSION_URL_BASE .. "?_ts=" .. salt
end

local function parseManifest(body)
    for line in body:gmatch("[^\r\n]+") do
        local k, v = line:match("^(.-)=(.-)$")
        if k == "latest_version" then latestVersion = v end
        if k == "release_stage"  then releaseStage  = v end
        if k == "changelog"      then changelog     = v end
        if k == "amount"         then fileAmount    = v end
    end
end

local function fetchVersionInfo(cb)
    local url = buildCacheBustedURL()
    info("Fetching version manifest...")
    PerformHttpRequest(url, function(code, body)
        if code == 200 and type(body) == "string" then
            parseManifest(body)
            ok(("Fetched version manifest (HTTP %s)"):format(code))
        else
            err(("Failed to fetch version info (HTTP %s)"):format(tostring(code)))
        end
        if cb then cb() end
    end, "GET", "", { ["Content-Type"] = "text/plain" })
end

-- =========================
-- Lifecycle
-- =========================
AddEventHandler("onResourceStart", function(res)
    if res ~= resourceName then return end
    info(("Resource '%s' starting..."):format(resourceName))
    info(("Current Version: %s"):format(CURRENT_VERSION))

    asciiBanner()

    fetchVersionInfo(function()
        banner()
        if latestVersion ~= "unknown" and CURRENT_VERSION ~= latestVersion then
            warn(("A newer version is available: %s (you are on %s)"):format(latestVersion, CURRENT_VERSION))
        else
            ok("You are on the latest known version.")
        end
    end)
end)

AddEventHandler("onResourceStop", function(res)
    if res ~= resourceName then return end
    info(("Resource '%s' stopped."):format(resourceName))
end)
