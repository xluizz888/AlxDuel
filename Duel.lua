local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local MaterialService = game:GetService("MaterialService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")
_G.AceIsMobile = true
_G.AceCursedResetRemote = _G.AceCursedResetRemote or nil
_G.AceCursedResetGuid = _G.AceCursedResetGuid or "f888ee6e-c86d-46e1-93d7-0639d6635d42"
pcall(function()
if not _G.AceCursedResetHooked and hookfunction and newcclosure then
_G.AceCursedResetHooked = true
local oldFire
oldFire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
if not _G.AceCursedResetRemote and typeof(self) == "Instance" and self:IsA("RemoteEvent") and self.Name:sub(1,3) == "RE/" then
_G.AceCursedResetRemote = self
end
return oldFire(self, ...)
end))
end
end)
function _G.AceCursedInstaReset()
if not _G.AceCursedResetRemote then
for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
if desc:IsA("RemoteEvent") and desc.Name:sub(1,3) == "RE/" then
_G.AceCursedResetRemote = desc
break
end
end
end
if not _G.AceCursedResetRemote then return end
local character = LP.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.Health <= 0 then
pcall(function() _G.AceCursedResetRemote:FireServer(_G.AceCursedResetGuid, LP, "balloon") end)
return
end
local resetDetected = false
local resetConns = {}
if humanoid then
table.insert(resetConns, humanoid.Died:Connect(function() resetDetected = true end))
table.insert(resetConns, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
if humanoid.Health <= 0 then resetDetected = true end
end))
end
if character then
table.insert(resetConns, character.AncestryChanged:Connect(function(_, parent)
if not parent then resetDetected = true end
end))
end
task.spawn(function()
for _ = 1, 10 do
if resetDetected then break end
pcall(function() _G.AceCursedResetRemote:FireServer(_G.AceCursedResetGuid, LP, "balloon") end)
task.wait(0.05)
end
for _, conn in ipairs(resetConns) do pcall(function() conn:Disconnect() end) end
end)
end
function cursedInstaReset()
return _G.AceCursedInstaReset()
end
for _, name in ipairs({"AceDuelsAdaptReconstruct", "AdaptHubPolished", "CyberHub"}) do
local old = PlayerGui:FindFirstChild(name)
if old then old:Destroy() end
end
local NS = 50
local CS = 25
local LAGGER_SPEED = 20
local LAGGER_CARRY_SPEED = 15
local currentSpeedMode = "Normal"
autoCarrySpeedEnabled = false
setAutoCarrySpeedVisual = nil
_G.AceAutoCarryWasCarrying = false
_G.AceAutoCarrySavedMode = nil
local autoStealEnabled = false
local selectedStealMode = "Normal"
local autoStealRadius = 62
_G.AceStealRadii = _G.AceStealRadii or {Normal = 62, Semi = 9}
local autoStealRadiusBox = nil
local selectedAimbotMode = "Normal"
local AIMBOT_SPEED = 58
local LAGGER_AIMBOT_SPEED = 40
_G.AceAntiBypassAimbotSpeed = _G.AceAntiBypassAimbotSpeed or 58
if _G.AceAntiBypassLaggerAimbotSpeed == nil or tonumber(_G.AceAntiBypassLaggerAimbotSpeed) == 58 then _G.AceAntiBypassLaggerAimbotSpeed = 40 end
local autoSwingEnabled = false
local mirrorTPDownEnabled = false
_G.AceNormalAimbotOn = _G.AceNormalAimbotOn or false
_G.AceAntiBypassAimbotOn = _G.AceAntiBypassAimbotOn or false
local antiDesyncAutoSwingEnabled = false
_G.AceAntiDesyncAimbotOn = _G.AceAntiDesyncAimbotOn or false
local ANTI_DESYNC_AIMBOT_SPEED = 58
local batCounterEnabled = false
local medCounterEnabled = false
local antiKickEnabled = false
local setSafeModeVisual = nil
local autoResetOnMedEnabled = false
local espEnabled = false
local ragdollCountdownEnabled = false
local fpsBoostEnabled = false
local antiLagVisualEnabled = false
local nukeOptimiserEnabled = false
local fovEnabled = false
local fovValue = 70
local noCamCollisionEnabled = false
_G.AceNoPlayerCollisionEnabled = _G.AceNoPlayerCollisionEnabled or false
local customFontVisualEnabled = false
local setPlayerESPVisual = nil
local setRagdollCountdownVisual = nil
local setFPSBoostVisual = nil
local setAntiLagVisual = nil
local setNukeOptimiserVisual = nil
local setFOVVisual = nil
local setNoCamCollisionVisual = nil
_G.AceSetNoPlayerCollisionVisual = _G.AceSetNoPlayerCollisionVisual or nil
local setCustomFontVisual = nil
local autoLeftEnabled = false
local autoRightEnabled = false
local DEFAULT_SPEED_KEYBINDS = {
SpeedToggle = Enum.KeyCode.Q,
LaggerToggle = Enum.KeyCode.R,
DropBrainrot = Enum.KeyCode.X,
Aimbot = Enum.KeyCode.E,
AntiDesyncAimbot = Enum.KeyCode.V,
AutoLeft = Enum.KeyCode.Z,
AutoRight = Enum.KeyCode.C,
InstantReset = Enum.KeyCode.T,
ToggleUI = Enum.KeyCode.LeftControl,
}
local DEFAULT_TP_DOWN_KEYBIND = Enum.KeyCode.F
local speedKeybinds = {
SpeedToggle = DEFAULT_SPEED_KEYBINDS.SpeedToggle,
LaggerToggle = DEFAULT_SPEED_KEYBINDS.LaggerToggle,
DropBrainrot = DEFAULT_SPEED_KEYBINDS.DropBrainrot,
Aimbot = DEFAULT_SPEED_KEYBINDS.Aimbot,
AntiDesyncAimbot = DEFAULT_SPEED_KEYBINDS.AntiDesyncAimbot,
AutoLeft = DEFAULT_SPEED_KEYBINDS.AutoLeft,
AutoRight = DEFAULT_SPEED_KEYBINDS.AutoRight,
InstantReset = DEFAULT_SPEED_KEYBINDS.InstantReset,
ToggleUI = DEFAULT_SPEED_KEYBINDS.ToggleUI,
}
local speedKeybindButtons = {}
local listeningForSpeedKey = nil
local autoTPEnabled = false
local autoTPHeight = 20
local autoTPConn = nil
local autoTPLastRun = 0
local autoTPClickDebounce = false
local tpDownKeybind = Enum.KeyCode.F
local tpDownKeybindButton = nil
local listeningForTPDownKey = false
local keybindListenStartedAt = 0
local setAutoTPVisual = nil
local function doAutoTPDown(force)
local char=LP.Character;if not char then return end
local hrp=char:FindFirstChild("HumanoidRootPart");if not hrp then return end
local hum2=char:FindFirstChildOfClass("Humanoid");if not hum2 then return end
if not force then
if hum2.FloorMaterial~=Enum.Material.Air then return end
if hrp.Position.Y<autoTPHeight then return end
end
hrp.CFrame=CFrame.new(hrp.Position.X,-7.00,hrp.Position.Z)
*CFrame.Angles(0,select(2,hrp.CFrame:ToEulerAnglesYXZ()),0)
hrp.AssemblyLinearVelocity=Vector3.zero
end
local function _clearAutoTPConnection()
if autoTPConn then
pcall(function() autoTPConn:Disconnect() end)
pcall(function() task.cancel(autoTPConn) end)
autoTPConn = nil
end
end
local function startAutoTP()
autoTPEnabled = true
_clearAutoTPConnection()
autoTPLastRun = 0
autoTPConn = RunService.Heartbeat:Connect(function()
if not autoTPEnabled then
_clearAutoTPConnection()
return
end
local now = tick()
if now - autoTPLastRun < 0.1 then return end
autoTPLastRun = now
pcall(function() doAutoTPDown(false) end)
end)
if setAutoTPVisual then setAutoTPVisual(true) end
end
local function stopAutoTP()
autoTPEnabled = false
_clearAutoTPConnection()
if setAutoTPVisual then setAutoTPVisual(false) end
end
local function runTPFloor()
pcall(function() doAutoTPDown(true) end)
end
local function toggleAutoTP(on)
if on then
startAutoTP()
else
stopAutoTP()
end
saveAceConfig()
end
function _G.AceStopAutoTPForAction()
if autoTPEnabled then
stopAutoTP()
pcall(function() if setAutoTPVisual then setAutoTPVisual(false) end end)
pcall(saveAceConfig)
end
end
local dropEnabled = false
local DROP_AUTO_OFF_DELAY = 0.15

local function runDropBrainrot()
    if dropEnabled then return end
    dropEnabled = true
    
    task.spawn(function()
        local colConn = RunService.Stepped:Connect(function()
            if not dropEnabled then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    for _, part in ipairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
        
        task.spawn(function()
            while dropEnabled do
                RunService.Heartbeat:Wait()
                local char = LP.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if not root then dropEnabled = false break end
                local vel = root.Velocity
                root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                RunService.RenderStepped:Wait()
                if root and root.Parent then root.Velocity = vel end
                RunService.Stepped:Wait()
                if root and root.Parent then root.Velocity = vel + Vector3.new(0, 0.1, 0) end
            end
        end)
        
        task.wait(DROP_AUTO_OFF_DELAY)
        dropEnabled = false
        colConn:Disconnect()
    end)
end
local infJumpEnabled = false
local antiRagdollEnabled = false
local antiRagdollConn = nil
local unwalkEnabled = false
local unwalkSavedAnimate = nil
local hitHarderAnimEnabled = false
local hitHarderOriginalAnims = {}
local selectedAnimationPack = "OFF"
local AnimationPacks = {
["Zombie"] = {
idle = {{"rbxassetid://616158929", 1}, {"rbxassetid://616158929", 1}},
walk = "rbxassetid://616168032", run = "rbxassetid://616163682",
jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", climb = "rbxassetid://616156119"
},
["Ninja"] = {
idle = {{"rbxassetid://656117400", 1}, {"rbxassetid://656117400", 1}},
walk = "rbxassetid://656121766", run = "rbxassetid://656118852",
jump = "rbxassetid://656117878", fall = "rbxassetid://656115606", climb = "rbxassetid://656114359"
},
["Knight"] = {
idle = {{"rbxassetid://657595757", 1}, {"rbxassetid://657595757", 1}},
walk = "rbxassetid://657552124", run = "rbxassetid://657564596",
jump = "rbxassetid://658409194", fall = "rbxassetid://657600338", climb = "rbxassetid://658360781"
},
["Elder"] = {
idle = {{"rbxassetid://845397899", 1}, {"rbxassetid://845397899", 1}},
walk = "rbxassetid://845403856", run = "rbxassetid://845386501",
jump = "rbxassetid://845398858", fall = "rbxassetid://845397673", climb = "rbxassetid://845392038"
},
["Levitate"] = {
idle = {{"rbxassetid://616006778", 1}, {"rbxassetid://616006778", 1}},
walk = "rbxassetid://616013216", run = "rbxassetid://616013216",
jump = "rbxassetid://616008936", fall = "rbxassetid://616005863", climb = "rbxassetid://616003713"
},
["Astronaut"] = {
idle = {{"rbxassetid://891621366", 1}, {"rbxassetid://891621366", 1}},
walk = "rbxassetid://891636393", run = "rbxassetid://891636393",
jump = "rbxassetid://891627522", fall = "rbxassetid://891617961", climb = "rbxassetid://891609353"
},
["Pirate"] = {
idle = {{"rbxassetid://750781874", 1}, {"rbxassetid://750781874", 1}},
walk = "rbxassetid://750785693", run = "rbxassetid://750783738",
jump = "rbxassetid://750782230", fall = "rbxassetid://750780242", climb = "rbxassetid://750779899"
},
["Toy"] = {
idle = {{"rbxassetid://782841498", 1}, {"rbxassetid://782841498", 1}},
walk = "rbxassetid://782843345", run = "rbxassetid://782842708",
jump = "rbxassetid://782847020", fall = "rbxassetid://782846423", climb = "rbxassetid://782843869"
},
["Vampire"] = {
idle = {{"rbxassetid://1083445855", 1}, {"rbxassetid://1083445855", 1}},
walk = "rbxassetid://1083473930", run = "rbxassetid://1083462077",
jump = "rbxassetid://1083455352", fall = "rbxassetid://1083443587", climb = "rbxassetid://1083439238"
},
["Werewolf"] = {
idle = {{"rbxassetid://1083195517", 1}, {"rbxassetid://1083195517", 1}},
walk = "rbxassetid://1083178339", run = "rbxassetid://1083216690",
jump = "rbxassetid://1083218792", fall = "rbxassetid://1083189019", climb = "rbxassetid://1083182000"
},
["Rthro"] = {
idle = {{"rbxassetid://2510196951", 1}, {"rbxassetid://2510196951", 1}},
walk = "rbxassetid://2510202577", run = "rbxassetid://2510198475",
jump = "rbxassetid://2510197830", fall = "rbxassetid://2510195892", climb = "rbxassetid://2510192778"
},
["Stylish"] = {
idle = {{"rbxassetid://616136790", 1}, {"rbxassetid://616136790", 1}},
walk = "rbxassetid://616146177", run = "rbxassetid://616140816",
jump = "rbxassetid://616139451", fall = "rbxassetid://616134815", climb = "rbxassetid://616133594"
},
}
local AnimationPackList = {"OFF", "Unwalk", "Hit Harder", "Zombie", "Ninja", "Knight", "Elder", "Levitate", "Astronaut", "Pirate", "Toy", "Vampire", "Werewolf", "Rthro", "Stylish"}
local AnimationPackIndex = 1
local OriginalAnims = {}
local enableUnwalk, disableUnwalk, enableHitHarderAnim, disableHitHarderAnim
local HIT_HARDER_ANIMS = {
idle1 = "rbxassetid://133806214992291",
idle2 = "rbxassetid://94970088341563",
walk = "rbxassetid://707897309",
run = "rbxassetid://707861613",
jump = "rbxassetid://116936326516985",
fall = "rbxassetid://116936326516985",
}
local function getAnimate(char)
char = char or LP.Character
return char and char:FindFirstChild("Animate") or nil
end
local function stopCurrentAnimations(char)
local hum = char and char:FindFirstChildOfClass("Humanoid")
if not hum then return end
for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
pcall(function() track:Stop(0) end)
end
end
local function backupAnimations(char)
local animate = getAnimate(char)
if not animate or next(OriginalAnims) ~= nil then return end
local function getId(obj) return obj and obj.AnimationId or nil end
OriginalAnims = {
idle1 = getId(animate.idle and animate.idle:FindFirstChild("Animation1")),
idle2 = getId(animate.idle and animate.idle:FindFirstChild("Animation2")),
walk = getId(animate.walk and animate.walk:FindFirstChild("WalkAnim")),
run = getId(animate.run and animate.run:FindFirstChild("RunAnim")),
jump = getId(animate.jump and animate.jump:FindFirstChild("JumpAnim")),
fall = getId(animate.fall and animate.fall:FindFirstChild("FallAnim")),
climb = getId(animate.climb and animate.climb:FindFirstChild("ClimbAnim")),
}
end
local function setAnimId(obj, id)
if obj and id then pcall(function() obj.AnimationId = id end) end
end
local function reloadAnimate(animate)
if not animate then return end
pcall(function()
animate.Disabled = true
task.wait()
animate.Disabled = false
end)
end
local function resetAnimations()
local char = LP.Character
local animate = getAnimate(char)
if not animate or next(OriginalAnims) == nil then return end
stopCurrentAnimations(char)
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation1"), OriginalAnims.idle1)
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation2"), OriginalAnims.idle2)
setAnimId(animate.walk and animate.walk:FindFirstChild("WalkAnim"), OriginalAnims.walk)
setAnimId(animate.run and animate.run:FindFirstChild("RunAnim"), OriginalAnims.run)
setAnimId(animate.jump and animate.jump:FindFirstChild("JumpAnim"), OriginalAnims.jump)
setAnimId(animate.fall and animate.fall:FindFirstChild("FallAnim"), OriginalAnims.fall)
setAnimId(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), OriginalAnims.climb)
reloadAnimate(animate)
end
local function applyAnimationPack(packName)
selectedAnimationPack = packName or "OFF"
if selectedAnimationPack ~= "Unwalk" and unwalkEnabled then
disableUnwalk()
end
if selectedAnimationPack ~= "Hit Harder" and hitHarderAnimEnabled then
hitHarderAnimEnabled = false
resetAnimations()
end
if selectedAnimationPack == "Unwalk" then
resetAnimations()
enableUnwalk()
return
end
if selectedAnimationPack == "Hit Harder" then
disableUnwalk()
enableHitHarderAnim()
return
end
if selectedAnimationPack == "OFF" then
resetAnimations()
return
end
local pack = AnimationPacks[selectedAnimationPack]
local char = LP.Character
local animate = getAnimate(char)
if not pack or not animate then return end
backupAnimations(char)
stopCurrentAnimations(char)
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation1"), pack.idle[1][1])
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation2"), pack.idle[2][1])
setAnimId(animate.walk and animate.walk:FindFirstChild("WalkAnim"), pack.walk)
setAnimId(animate.run and animate.run:FindFirstChild("RunAnim"), pack.run)
setAnimId(animate.jump and animate.jump:FindFirstChild("JumpAnim"), pack.jump)
setAnimId(animate.fall and animate.fall:FindFirstChild("FallAnim"), pack.fall)
setAnimId(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), pack.climb)
reloadAnimate(animate)
end
enableUnwalk = function()
unwalkEnabled = true
local char = LP.Character
local animate = getAnimate(char)
if animate then
if not unwalkSavedAnimate then
unwalkSavedAnimate = animate:Clone()
end
stopCurrentAnimations(char)
animate:Destroy()
end
end
disableUnwalk = function()
unwalkEnabled = false
local char = LP.Character
if char and not char:FindFirstChild("Animate") and unwalkSavedAnimate then
local newAnimate = unwalkSavedAnimate:Clone()
newAnimate.Parent = char
end
end
enableHitHarderAnim = function()
hitHarderAnimEnabled = true
local char = LP.Character
local animate = getAnimate(char)
if not animate then return end
backupAnimations(char)
stopCurrentAnimations(char)
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation1"), HIT_HARDER_ANIMS.idle1)
setAnimId(animate.idle and animate.idle:FindFirstChild("Animation2"), HIT_HARDER_ANIMS.idle2)
setAnimId(animate.walk and animate.walk:FindFirstChild("WalkAnim"), HIT_HARDER_ANIMS.walk)
setAnimId(animate.run and animate.run:FindFirstChild("RunAnim"), HIT_HARDER_ANIMS.run)
setAnimId(animate.jump and animate.jump:FindFirstChild("JumpAnim"), HIT_HARDER_ANIMS.jump)
setAnimId(animate.fall and animate.fall:FindFirstChild("FallAnim"), HIT_HARDER_ANIMS.fall)
reloadAnimate(animate)
end
disableHitHarderAnim = function()
hitHarderAnimEnabled = false
resetAnimations()
if selectedAnimationPack ~= "OFF" then
task.wait()
applyAnimationPack(selectedAnimationPack)
end
end
local function startAntiRagdoll()
if antiRagdollConn then return end
antiRagdollConn = RunService.Heartbeat:Connect(function()
if not antiRagdollEnabled then return end
local char = LP.Character
if not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")
if not (hum and root) then return end
local s = hum:GetState()
local ragdolled = (
s == Enum.HumanoidStateType.Physics
or s == Enum.HumanoidStateType.Ragdoll
or s == Enum.HumanoidStateType.FallingDown
)
local endTime = LP:GetAttribute("RagdollEndTime")
if endTime and (endTime - workspace:GetServerTimeNow()) > 0 then
ragdolled = true
end
if ragdolled then
pcall(function()
LP:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
end)
for _, d in ipairs(char:GetDescendants()) do
if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and d.Name:find("RagdollAttachment")) then
pcall(function() d:Destroy() end)
end
end
for _, obj in ipairs(char:GetDescendants()) do
if obj:IsA("Motor6D") and obj.Enabled == false then
obj.Enabled = true
end
end
if hum.Health > 0 then
hum:ChangeState(Enum.HumanoidStateType.Running)
end
workspace.CurrentCamera.CameraSubject = hum
root.Anchored = false
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end
end)
end
local function stopAntiRagdoll()
if antiRagdollConn then
antiRagdollConn:Disconnect()
antiRagdollConn = nil
end
end
local function setAntiRagdoll(on)
antiRagdollEnabled = on and true or false
if antiRagdollEnabled then
startAntiRagdoll()
else
stopAntiRagdoll()
end
end
_G.AceNormalInfJump = _G.AceNormalInfJump or {holdPressed=false, holdActive=false, controllerActive=false, mobilePressed=false, mobileActive=false, hooked={}}
function _G.AceStopNormalInfJumpHoldState()
local S = _G.AceNormalInfJump
S.holdPressed = false
S.holdActive = false
S.controllerActive = false
S.mobilePressed = false
S.mobileActive = false
end
function _G.AceApplyNormalInfJumpBoost(boost)
if not infJumpEnabled then return end
local char = LP.Character
local root = char and char:FindFirstChild("HumanoidRootPart")
local hum = char and char:FindFirstChildOfClass("Humanoid")
if not root or not hum or hum.Health <= 0 then return end
root.Velocity = Vector3.new(root.Velocity.X, boost or 50, root.Velocity.Z)
end
UserInputService.JumpRequest:Connect(function()
_G.AceApplyNormalInfJumpBoost(50)
end)
UserInputService.InputBegan:Connect(function(input)
if UserInputService:GetFocusedTextBox() then return end
local S = _G.AceNormalInfJump
if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
S.holdPressed = true
task.delay(0.12, function()
if _G.AceNormalInfJump.holdPressed and infJumpEnabled then
_G.AceNormalInfJump.holdActive = true
_G.AceApplyNormalInfJumpBoost(50)
end
end)
elseif input.KeyCode == Enum.KeyCode.ButtonA and input.UserInputType.Name:match("^Gamepad") then
S.controllerActive = true
end
end)
UserInputService.InputEnded:Connect(function(input)
local S = _G.AceNormalInfJump
if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
S.holdPressed = false
S.holdActive = false
end
if input.KeyCode == Enum.KeyCode.ButtonA and input.UserInputType.Name:match("^Gamepad") then
S.controllerActive = false
end
end)
function _G.AceHookNormalInfMobileJumpButton(obj)
local S = _G.AceNormalInfJump
if not obj or obj.Name ~= "JumpButton" or not obj:IsA("GuiButton") or S.hooked[obj] then return end
S.hooked[obj] = true
obj.InputBegan:Connect(function(input)
if input.UserInputType ~= Enum.UserInputType.Touch or not infJumpEnabled then return end
_G.AceNormalInfJump.mobilePressed = true
task.delay(0.12, function()
if _G.AceNormalInfJump.mobilePressed and infJumpEnabled then
_G.AceNormalInfJump.mobileActive = true
_G.AceApplyNormalInfJumpBoost(50)
end
end)
end)
obj.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch then
_G.AceNormalInfJump.mobilePressed = false
_G.AceNormalInfJump.mobileActive = false
end
end)
obj.AncestryChanged:Connect(function(_, parent)
if not parent then
_G.AceNormalInfJump.hooked[obj] = nil
_G.AceNormalInfJump.mobilePressed = false
_G.AceNormalInfJump.mobileActive = false
end
end)
end
for _, obj in ipairs(PlayerGui:GetDescendants()) do
_G.AceHookNormalInfMobileJumpButton(obj)
end
PlayerGui.DescendantAdded:Connect(function(obj)
task.defer(_G.AceHookNormalInfMobileJumpButton, obj)
end)
RunService.Heartbeat:Connect(function()
local S = _G.AceNormalInfJump
if infJumpEnabled and (S.holdActive or S.mobileActive or S.controllerActive) then
_G.AceApplyNormalInfJumpBoost(50)
end
end)
setInfJumpInternal = function(on)
infJumpEnabled = on and true or false
if not infJumpEnabled then
_G.AceStopNormalInfJumpHoldState()
end
end
local currentBackground = 0
local aceGuiScaleValue = 0.52
local aceProgressBarScaleValue = 0.83
CONFIG_FILE = "AlxDuels_MainGUI_Config_DefaultsV2.json"
KEYBINDS_CONFIG_FILE = "AlxDuels_Keybinds_DefaultsV2.json"
_ace_isfile = isfile or (syn and syn.isfile) or function(path)
local ok, result = pcall(function() return readfile(path) end)
return ok and result ~= nil
end
_ace_readfile = readfile or (syn and syn.readfile)
_ace_writefile = writefile or (syn and syn.writefile)
canSaveConfig = (type(_ace_readfile) == "function" and type(_ace_writefile) == "function")

--// ALX Duels Intro + Songs
selectedIntroMusic = selectedIntroMusic or 1
_introEnabled = (_introEnabled ~= false)
setIntroVisual = nil
setIntroSongVisual = nil
INTRO_MUSIC_OPTIONS = INTRO_MUSIC_OPTIONS or {
{name="Song 1", url="https://files.catbox.moe/mzvrir.mp3", file="AlxDuelsIntroSong_1.mp3"},
{name="Song 2", url="https://files.catbox.moe/2a7jyx.mp3", file="AlxDuelsIntroSong_2.mp3"},
{name="Song 3", url="https://files.catbox.moe/rcgr9f.mp3", file="AlxDuelsIntroSong_3.mp3"},
{name="Song 4", url="https://files.catbox.moe/iknfuh.mp3", file="AlxDuelsIntroSong_4.mp3"},
{name="Song 5", url="https://files.catbox.moe/6eigoh.mp3", file="AlxDuelsIntroSong_5.mp3"},
{name="Song 6", url="https://files.catbox.moe/dvjtjk.mp3", file="AlxDuelsIntroSong_6.mp3"},
{name="Song 7", url="https://files.catbox.moe/iyw1cb.mp3", file="AlxDuelsIntroSong_7.mp3"},
}
function getIntroSongName()
local opt = INTRO_MUSIC_OPTIONS[selectedIntroMusic]
return opt and opt.name or "No Songs Added"
end
introPreviewSound = nil
introPlaybackSound = nil
introPreviewToken = 0
introPlaybackToken = 0
introSongCache = introSongCache or {}
introSongDownloading = introSongDownloading or {}
function stopIntroPreview()
introPreviewToken = introPreviewToken + 1
if introPreviewSound then
pcall(function() introPreviewSound:Stop() end)
pcall(function() introPreviewSound:Destroy() end)
introPreviewSound = nil
end
end
function stopIntroPlayback()
introPlaybackToken = introPlaybackToken + 1
if introPlaybackSound then
pcall(function() introPlaybackSound:Stop() end)
pcall(function() introPlaybackSound:Destroy() end)
introPlaybackSound = nil
end
end
function _safeNotify(msg)
if showActionNotification then pcall(function() showActionNotification(msg) end) end
end
function cacheIntroSong(option, allowDownload)
if not option or not option.url or option.url == "" then return nil end
if not (writefile and getcustomasset) then return nil end
local fileName = option.file or ("AlxDuelsIntroSong_" .. tostring(option.name or "song") .. ".mp3")
local function loadExisting()
if introSongCache[fileName] then return introSongCache[fileName] end
local hasFile = false
pcall(function() hasFile = isfile and isfile(fileName) end)
if hasFile then
local ok = pcall(function() introSongCache[fileName] = getcustomasset(fileName) end)
if ok and introSongCache[fileName] then return introSongCache[fileName] end
end
return nil
end
local cached = loadExisting()
if cached then return cached end
if allowDownload == false then return nil end
if introSongDownloading[fileName] then
local waitStart = tick()
while introSongDownloading[fileName] and tick() - waitStart < 12 do task.wait(0.05) end
cached = loadExisting()
if cached then return cached end
end
introSongDownloading[fileName] = true
local ok = pcall(function()
local data = game:HttpGet(option.url)
if data and #data > 0 then
writefile(fileName, data)
introSongCache[fileName] = getcustomasset(fileName)
end
end)
introSongDownloading[fileName] = nil
if ok and introSongCache[fileName] then return introSongCache[fileName] end
return loadExisting()
end
function preloadIntroSongs()
task.spawn(function()
cacheIntroSong(INTRO_MUSIC_OPTIONS[selectedIntroMusic], true)
for _, option in ipairs(INTRO_MUSIC_OPTIONS) do
if option ~= INTRO_MUSIC_OPTIONS[selectedIntroMusic] then
cacheIntroSong(option, true)
task.wait(0.05)
end
end
end)
end
function makeIntroSoundFromId(soundId, name, parent)
if not soundId then return nil end
local sound = Instance.new("Sound")
sound.Name = name or "AlxDuelsIntroMusic"
sound.Volume = 0.65
sound.Looped = false
sound.SoundId = soundId
sound.Parent = parent or SoundService
return sound
end
function createIntroSound(option, fileName, parent, allowDownload)
if not option then return nil end
local soundId = cacheIntroSong(option, allowDownload)
if not soundId then return nil end
return makeIntroSoundFromId(soundId, fileName, parent)
end
function previewIntroMusic(index)
stopIntroPreview()
stopIntroPlayback()
if not INTRO_MUSIC_OPTIONS[index] then _safeNotify("ADD SONG LINKS"); return end
local token = introPreviewToken
task.spawn(function()
local option = INTRO_MUSIC_OPTIONS[index]
local sound = createIntroSound(option, "AlxDuelsIntroPreview_" .. tostring(token), SoundService, true)
if token ~= introPreviewToken then if sound then sound:Destroy() end; return end
introPreviewSound = sound
if not sound then _safeNotify("SONG LOADING..."); return end
sound.TimePosition = 0
pcall(function() sound:Play() end)
task.delay(15, function() if token == introPreviewToken then stopIntroPreview() end end)
end)
end
function playIntroMusic()
stopIntroPreview()
stopIntroPlayback()
if not _introEnabled then return end
local option = INTRO_MUSIC_OPTIONS[selectedIntroMusic]
if not option then return end
local token = introPlaybackToken
task.spawn(function()
local sound = createIntroSound(option, "AlxDuelsIntroMusic_" .. tostring(token), SoundService, true)
if token ~= introPlaybackToken or not _introEnabled then if sound then pcall(function() sound:Destroy() end) end; return end
introPlaybackSound = sound
if not sound then _safeNotify("SONG FAILED"); return end
sound.TimePosition = 0
local loadStart = tick()
while sound and not sound.IsLoaded and tick() - loadStart < 10 do task.wait(0.05) end
pcall(function() sound:Play() end)
task.delay(15, function() if token == introPlaybackToken then stopIntroPlayback() end end)
end)
end
preloadIntroSongs()

savedConfig = {}
_G.AceGuiLocked = _G.AceGuiLocked == true
_G.AceHideMobileButtons = _G.AceHideMobileButtons == true
_G.AceMobileButtonScale = 0.75
_G.AceMobileButtonPositions = _G.AceMobileButtonPositions or {}
savedMainPositionTable = nil
savedMiniPositionTable = nil
function udim2ToTable(u)
return {xs = u.X.Scale, xo = u.X.Offset, ys = u.Y.Scale, yo = u.Y.Offset}
end
function tableToUDim2(t, fallback)
if type(t) == "table" then
return UDim2.new(tonumber(t.xs) or 0, tonumber(t.xo) or 0, tonumber(t.ys) or 0, tonumber(t.yo) or 0)
end
return fallback
end
function collectAceMobileButtonPositions()
local out = {}
for key, entry in pairs(_G.AceMobileButtonRefs or {}) do
local holder = entry and entry.holder
if holder then out[key] = udim2ToTable(holder.Position) end
end
if next(out) == nil and type(_G.AceMobileButtonPositions) == "table" then
return _G.AceMobileButtonPositions
end
_G.AceMobileButtonPositions = out
return out
end
function keyToString(key)
if not key then return "None" end
return tostring(key):gsub("Enum.KeyCode.", "")
end
function stringToKeyCode(value)
if type(value) ~= "string" or value == "" or value == "None" then return nil end
return Enum.KeyCode[value]
end
function keybindsToTable()
local out = {}
for keyId in pairs(DEFAULT_SPEED_KEYBINDS) do
out[keyId] = keyToString(speedKeybinds[keyId])
end
for keyId, key in pairs(speedKeybinds) do
out[keyId] = keyToString(key)
end
return out
end
function collectAceKeybindConfig()
return {
keybinds = keybindsToTable(),
tpDownKeybind = keyToString(tpDownKeybind),
}
end
function applySavedKeybinds(t)
if type(t) ~= "table" then return end
for keyId in pairs(speedKeybinds) do
if t[keyId] ~= nil then
speedKeybinds[keyId] = stringToKeyCode(t[keyId])
end
end
end
function applyDefaultAceKeybinds()
for keyId, key in pairs(DEFAULT_SPEED_KEYBINDS) do
speedKeybinds[keyId] = key
end
tpDownKeybind = DEFAULT_TP_DOWN_KEYBIND
end
function collectAceConfig()
return {
mainPosition = savedMainPositionTable,
keybinds = keybindsToTable(),
tpDownKeybind = keyToString(tpDownKeybind),
NS = NS,
CS = CS,
LAGGER_SPEED = LAGGER_SPEED,
LAGGER_CARRY_SPEED = LAGGER_CARRY_SPEED,
currentSpeedMode = currentSpeedMode,
autoCarrySpeedEnabled = autoCarrySpeedEnabled == true,
autoTPEnabled = autoTPEnabled,
autoTPHeight = autoTPHeight,
infJumpEnabled = infJumpEnabled,
antiRagdollEnabled = antiRagdollEnabled,
selectedAnimationPack = selectedAnimationPack,
selectedStealMode = selectedStealMode,
autoStealEnabled = autoStealEnabled,
autoStealRadius = autoStealRadius,
aceStealRadii = _G.AceStealRadii,
selectedAimbotMode = selectedAimbotMode,
AIMBOT_SPEED = AIMBOT_SPEED,
LAGGER_AIMBOT_SPEED = LAGGER_AIMBOT_SPEED,
ANTI_BYPASS_AIMBOT_SPEED = _G.AceAntiBypassAimbotSpeed,
ANTI_BYPASS_LAGGER_AIMBOT_SPEED = _G.AceAntiBypassLaggerAimbotSpeed,
ANTI_DESYNC_AIMBOT_SPEED = ANTI_DESYNC_AIMBOT_SPEED,
autoSwingEnabled = autoSwingEnabled,
mirrorTPDownEnabled = mirrorTPDownEnabled,
normalAimbotEnabled = _G.AceNormalAimbotOn == true,
antiBypassAimbotEnabled = _G.AceAntiBypassAimbotOn == true,
antiDesyncAutoSwingEnabled = antiDesyncAutoSwingEnabled,
antiDesyncAimbotEnabled = _G.AceAntiDesyncAimbotOn == true,
batCounterEnabled = batCounterEnabled,
medCounterEnabled = medCounterEnabled,
safeMode = antiKickEnabled == true,
autoResetOnMedEnabled = autoResetOnMedEnabled,
espEnabled = espEnabled,
ragdollCountdownEnabled = ragdollCountdownEnabled,
fpsBoostEnabled = fpsBoostEnabled,
antiLagVisualEnabled = antiLagVisualEnabled,
nukeOptimiserEnabled = nukeOptimiserEnabled,
fovEnabled = fovEnabled,
fovValue = fovValue,
noCamCollisionEnabled = noCamCollisionEnabled,
noPlayerCollisionEnabled = _G.AceNoPlayerCollisionEnabled,
customFontVisualEnabled = false,
autoLeftEnabled = autoLeftEnabled,
autoRightEnabled = autoRightEnabled,
currentBackground = currentBackground,
aceGuiScaleValue = aceGuiScaleValue,
aceProgressBarScaleValue = aceProgressBarScaleValue,
introEnabled = _introEnabled == true,
selectedIntroMusic = selectedIntroMusic,
guiLocked = _G.AceGuiLocked == true,
hideMobileButtons = _G.AceHideMobileButtons == true,
aceMobileButtonScale = _G.AceMobileButtonScale,
mobileButtonPositions = collectAceMobileButtonPositions(),
}
end
function saveAceConfig()
if not canSaveConfig then return end
pcall(function()
_ace_writefile(CONFIG_FILE, HttpService:JSONEncode(collectAceConfig()))
_ace_writefile(KEYBINDS_CONFIG_FILE, HttpService:JSONEncode(collectAceKeybindConfig()))
end)
end
function loadAceConfig()
if not canSaveConfig or not _ace_isfile(CONFIG_FILE) then return end
local ok, data = pcall(function()
return HttpService:JSONDecode(_ace_readfile(CONFIG_FILE))
end)
if not ok or type(data) ~= "table" then return end
savedConfig = data
local keybindData = data
pcall(function()
if _ace_isfile(KEYBINDS_CONFIG_FILE) then
local kb = HttpService:JSONDecode(_ace_readfile(KEYBINDS_CONFIG_FILE))
if type(kb) == "table" then keybindData = kb end
end
end)
savedMainPositionTable = data.mainPosition
savedMiniPositionTable = nil
_G.AceGuiLocked = data.guiLocked == true
_G.AceHideMobileButtons = data.hideMobileButtons == true
_G.AceMobileButtonScale = math.clamp(tonumber(data.aceMobileButtonScale) or tonumber(_G.AceMobileButtonScale) or 0.75, 0.30, 1.35)
_G.AceMobileButtonPositions = type(data.mobileButtonPositions) == "table" and data.mobileButtonPositions or {}
applySavedKeybinds(keybindData.keybinds)
if keybindData.tpDownKeybind ~= nil then
if tostring(keybindData.tpDownKeybind) == "None" then
tpDownKeybind = nil
else
tpDownKeybind = stringToKeyCode(keybindData.tpDownKeybind) or DEFAULT_TP_DOWN_KEYBIND
end
end
for keyId, defaultKey in pairs(DEFAULT_SPEED_KEYBINDS) do
local savedKeys = keybindData and keybindData.keybinds
if (not savedKeys or savedKeys[keyId] == nil) and speedKeybinds[keyId] == nil then
speedKeybinds[keyId] = defaultKey
end
end
NS = tonumber(data.NS) or NS
CS = tonumber(data.CS) or CS
LAGGER_SPEED = tonumber(data.LAGGER_SPEED) or LAGGER_SPEED
LAGGER_CARRY_SPEED = tonumber(data.LAGGER_CARRY_SPEED) or LAGGER_CARRY_SPEED
currentSpeedMode = data.currentSpeedMode or currentSpeedMode
if currentSpeedMode ~= "Normal" and currentSpeedMode ~= "Carry" and currentSpeedMode ~= "Lagger" and currentSpeedMode ~= "Lagger Carry" then currentSpeedMode = "Normal" end
autoCarrySpeedEnabled = data.autoCarrySpeedEnabled == true
autoTPEnabled = data.autoTPEnabled == true
autoTPHeight = tonumber(data.autoTPHeight) or autoTPHeight
infJumpEnabled = data.infJumpEnabled == true
antiRagdollEnabled = data.antiRagdollEnabled == true
selectedAnimationPack = data.selectedAnimationPack or selectedAnimationPack
selectedStealMode = data.selectedStealMode or selectedStealMode
if selectedStealMode ~= "Semi" then selectedStealMode = "Normal" end
autoStealEnabled = data.autoStealEnabled == true
if type(data.aceStealRadii) == "table" then
_G.AceStealRadii.Normal = tonumber(data.aceStealRadii.Normal) or _G.AceStealRadii.Normal or 62
_G.AceStealRadii.Semi = tonumber(data.aceStealRadii.Semi) or _G.AceStealRadii.Semi or 9
end
autoStealRadius = tonumber(data.autoStealRadius) or autoStealRadius
if selectedStealMode == "Normal" then
_G.AceStealRadii.Normal = tonumber(autoStealRadius) or _G.AceStealRadii.Normal or 62
autoStealRadius = _G.AceStealRadii.Normal
else
autoStealRadius = _G.AceStealRadii.Semi or 9
end
selectedAimbotMode = data.selectedAimbotMode or selectedAimbotMode
if selectedAimbotMode ~= "Anti Bypass" then selectedAimbotMode = "Normal" end
AIMBOT_SPEED = tonumber(data.AIMBOT_SPEED) or AIMBOT_SPEED
LAGGER_AIMBOT_SPEED = tonumber(data.LAGGER_AIMBOT_SPEED) or LAGGER_AIMBOT_SPEED
_G.AceAntiBypassAimbotSpeed = tonumber(data.ANTI_BYPASS_AIMBOT_SPEED) or _G.AceAntiBypassAimbotSpeed or 58
if data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED == nil or tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) == 58 then
_G.AceAntiBypassLaggerAimbotSpeed = 40
else
_G.AceAntiBypassLaggerAimbotSpeed = tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) or 40
end
ANTI_DESYNC_AIMBOT_SPEED = tonumber(data.ANTI_DESYNC_AIMBOT_SPEED) or ANTI_DESYNC_AIMBOT_SPEED or 58
autoSwingEnabled = data.autoSwingEnabled == true
mirrorTPDownEnabled = data.mirrorTPDownEnabled == true
_G.AceNormalAimbotOn = data.normalAimbotEnabled == true
_G.AceAntiBypassAimbotOn = data.antiBypassAimbotEnabled == true
antiDesyncAutoSwingEnabled = data.antiDesyncAutoSwingEnabled == true
_G.AceAntiDesyncAimbotOn = data.antiDesyncAimbotEnabled == true
batCounterEnabled = data.batCounterEnabled == true
medCounterEnabled = data.medCounterEnabled == true
antiKickEnabled = data.safeMode == true
autoResetOnMedEnabled = data.autoResetOnMedEnabled == true
espEnabled = data.espEnabled == true
ragdollCountdownEnabled = data.ragdollCountdownEnabled == true
fpsBoostEnabled = data.fpsBoostEnabled == true
antiLagVisualEnabled = data.antiLagVisualEnabled == true
nukeOptimiserEnabled = data.nukeOptimiserEnabled == true
fovEnabled = data.fovEnabled == true
fovValue = tonumber(data.fovValue) or fovValue
noCamCollisionEnabled = data.noCamCollisionEnabled == true
_G.AceNoPlayerCollisionEnabled = data.noPlayerCollisionEnabled == true
customFontVisualEnabled = false
autoLeftEnabled = data.autoLeftEnabled == true
autoRightEnabled = data.autoRightEnabled == true
if data.introEnabled ~= nil then _introEnabled = data.introEnabled == true end
if data.selectedIntroMusic and INTRO_MUSIC_OPTIONS[data.selectedIntroMusic] then selectedIntroMusic = data.selectedIntroMusic end
if autoLeftEnabled and autoRightEnabled then autoRightEnabled = false end
end
loadAceConfig()
local function syncAnimationPackIndex()
for i, name in ipairs(AnimationPackList) do
if name == selectedAnimationPack then
AnimationPackIndex = i
return
end
end
selectedAnimationPack = "OFF"
AnimationPackIndex = 1
end
local function applySavedAnimationPackToCharacter(char)
syncAnimationPackIndex()
if refreshAnimationPackRow then pcall(refreshAnimationPackRow) end
if not char then char = LP.Character end
if not char then return end
local animate = char:FindFirstChild("Animate") or char:WaitForChild("Animate", 6)
if not animate then return end
task.wait(0.2)
OriginalAnims = {}
unwalkSavedAnimate = nil
if selectedAnimationPack and selectedAnimationPack ~= "OFF" then
pcall(function() applyAnimationPack(selectedAnimationPack) end)
else
pcall(function() resetAnimations() end)
end
end
syncAnimationPackIndex()
task.defer(function()
applySavedAnimationPackToCharacter(LP.Character)
end)
LP.CharacterAdded:Connect(function(char)
task.wait(0.65)
applySavedAnimationPackToCharacter(char)
end)
_G.AceAutoResetOnMed = _G.AceAutoResetOnMed or {}
_G.AceAutoResetOnMed.conns = _G.AceAutoResetOnMed.conns or {}
_G.AceAutoResetOnMed.enabled = autoResetOnMedEnabled == true
_G.AceAutoResetOnMed.medTriggered = false
_G.AceAutoResetOnMed.lastFire = _G.AceAutoResetOnMed.lastFire or 0
_G.AceAutoResetOnMed.cooldown = 2.25
_G.AceAutoResetOnMed.charAddedConn = _G.AceAutoResetOnMed.charAddedConn
_G.AceCursedResetGuid = _G.AceCursedResetGuid or "f888ee6e-c86d-46e1-93d7-0639d6635d42"
_G.AceCursedResetRemote = _G.AceCursedResetRemote or nil
pcall(function()
if hookfunction and newcclosure and not _G.AceCursedResetHooked and not _G.AceAutoResetOnMed.remoteHooked then
_G.AceAutoResetOnMed.remoteHooked = true
local oldFire
oldFire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
if not _G.AceCursedResetRemote
and typeof(self) == "Instance"
and self:IsA("RemoteEvent")
and self.Name:sub(1, 3) == "RE/" then
_G.AceCursedResetRemote = self
end
return oldFire(self, ...)
end))
end
end)
function _G.AceFindCursedResetRemote()
if _G.AceCursedResetRemote then return _G.AceCursedResetRemote end
for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
if desc:IsA("RemoteEvent") and desc.Name:sub(1, 3) == "RE/" then
_G.AceCursedResetRemote = desc
break
end
end
return _G.AceCursedResetRemote
end
function _G.AceAutoResetCursedInstaReset()
local remote = _G.AceFindCursedResetRemote and _G.AceFindCursedResetRemote() or _G.AceCursedResetRemote
if not remote then return end
local character = LP.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.Health <= 0 then
pcall(function()
remote:FireServer(_G.AceCursedResetGuid, LP, "balloon")
end)
return
end
local resetDetected = false
local resetConns = {}
if humanoid then
table.insert(resetConns, humanoid.Died:Connect(function()
resetDetected = true
end))
table.insert(resetConns, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
if humanoid.Health <= 0 then
resetDetected = true
end
end))
end
if character then
table.insert(resetConns, character.AncestryChanged:Connect(function(_, parent)
if not parent then
resetDetected = true
end
end))
end
task.spawn(function()
for _ = 1, 10 do
if resetDetected then break end
pcall(function()
remote:FireServer(_G.AceCursedResetGuid, LP, "balloon")
end)
task.wait(0.05)
end
for _, conn in ipairs(resetConns) do
pcall(function()
conn:Disconnect()
end)
end
end)
end
function _G.AceAutoResetShouldFire(part)
local state = _G.AceAutoResetOnMed
if not state or not state.enabled then return false end
if state.medTriggered then return false end
if tick() - (state.lastFire or 0) < (state.cooldown or 2.25) then return false end
if not part or not part.Parent then return false end
if part:FindFirstAncestorOfClass("Tool") or part:FindFirstAncestorOfClass("Accessory") then
return false
end
return part.Anchored and part.Transparency == 1
end
function _G.AceAutoResetFireOnce(part)
if not _G.AceAutoResetShouldFire(part) then return end
local state = _G.AceAutoResetOnMed
state.medTriggered = true
state.lastFire = tick()
task.delay(2.3, function()
if state.enabled then
if _G.AceAutoResetCursedInstaReset then
_G.AceAutoResetCursedInstaReset()
elseif cursedInstaReset then
cursedInstaReset()
end
end
end)
end
function _G.AceAutoResetOnAnchorChanged(part)
return part:GetPropertyChangedSignal("Anchored"):Connect(function()
_G.AceAutoResetFireOnce(part)
end)
end
function _G.AceStopAutoResetOnMed()
local state = _G.AceAutoResetOnMed
if not state then return end
for _, conn in ipairs(state.conns or {}) do
pcall(function()
conn:Disconnect()
end)
end
state.conns = {}
state.medTriggered = false
end
function _G.AceStartAutoResetOnMed(char)
local state = _G.AceAutoResetOnMed
if not state then return end
_G.AceStopAutoResetOnMed()
state.medTriggered = false
char = char or LP.Character
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
table.insert(state.conns, _G.AceAutoResetOnAnchorChanged(part))
_G.AceAutoResetFireOnce(part)
end
end
table.insert(state.conns, char.DescendantAdded:Connect(function(part)
if part:IsA("BasePart") then
table.insert(state.conns, _G.AceAutoResetOnAnchorChanged(part))
_G.AceAutoResetFireOnce(part)
end
end))
table.insert(state.conns, char.AncestryChanged:Connect(function(_, parent)
if not parent then
state.medTriggered = false
end
end))
end
function _G.AceEnableAutoResetOnMed()
autoResetOnMedEnabled = true
_G.AceAutoResetOnMed.enabled = true
_G.AceStartAutoResetOnMed(LP.Character)
end
function _G.AceDisableAutoResetOnMed()
autoResetOnMedEnabled = false
_G.AceAutoResetOnMed.enabled = false
_G.AceStopAutoResetOnMed()
end
function _G.AceSetAutoResetOnMed(state, noSave)
autoResetOnMedEnabled = state == true
if autoResetOnMedEnabled then
_G.AceEnableAutoResetOnMed()
else
_G.AceDisableAutoResetOnMed()
end
if setAutoResetOnMedVisual then
setAutoResetOnMedVisual(autoResetOnMedEnabled)
end
if not noSave and saveAceConfig then saveAceConfig() end
end
function enableAutoResetOnMed()
_G.AceSetAutoResetOnMed(true)
end
function disableAutoResetOnMed()
_G.AceSetAutoResetOnMed(false)
end
function toggleAutoResetOnMed(on)
_G.AceSetAutoResetOnMed(on == true)
end
if not _G.AceAutoResetOnMed.charAddedConn then
_G.AceAutoResetOnMed.charAddedConn = LP.CharacterAdded:Connect(function(char)
if _G.AceAutoResetOnMed and _G.AceAutoResetOnMed.enabled then
task.wait(0.25)
_G.AceStartAutoResetOnMed(char)
end
end)
end
_G.AceCounterState = _G.AceCounterState or {}
_G.AceCounterState.batConn = nil
_G.AceCounterState.batDebounce = false
_G.AceCounterState.medConns = _G.AceCounterState.medConns or {}
_G.AceCounterState.medDebounce = false
_G.AceCounterState.medLastUsed = _G.AceCounterState.medLastUsed or 0
_G.AceMedusaCooldown = 25
function _G.AceFindMedusa()
local c = LP.Character
if not c then return nil end
for _, t in ipairs(c:GetChildren()) do
if t:IsA("Tool") then
local n = t.Name:lower()
if n:find("medusa") or n:find("head") or n:find("stone") then return t end
end
end
local bp = LP:FindFirstChild("Backpack") or LP:FindFirstChildOfClass("Backpack")
if bp then
for _, t in ipairs(bp:GetChildren()) do
if t:IsA("Tool") then
local n = t.Name:lower()
if n:find("medusa") or n:find("head") or n:find("stone") then return t end
end
end
end
return nil
end
function _G.AceUseMedusaCounter()
if not medCounterEnabled then return end
if _G.AceCounterState.medDebounce then return end
if tick() - (_G.AceCounterState.medLastUsed or 0) < _G.AceMedusaCooldown then return end
local c = LP.Character
if not c then return end
_G.AceCounterState.medDebounce = true
local med = _G.AceFindMedusa()
if not med then
_G.AceCounterState.medDebounce = false
return
end
if med.Parent ~= c then
local hum = c:FindFirstChildOfClass("Humanoid")
if hum then pcall(function() hum:EquipTool(med) end) end
task.wait(0.05)
end
pcall(function() med:Activate() end)
_G.AceCounterState.medLastUsed = tick()
_G.AceCounterState.medDebounce = false
end
function _G.AceOnMedusaAnchorChanged(part)
return part:GetPropertyChangedSignal("Anchored"):Connect(function()
if medCounterEnabled and part.Anchored and part.Transparency == 1 then
_G.AceUseMedusaCounter()
end
end)
end
function _G.AceStartMedCounter(char)
_G.AceStopMedCounter()
char = char or LP.Character
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
table.insert(_G.AceCounterState.medConns, _G.AceOnMedusaAnchorChanged(part))
end
end
table.insert(_G.AceCounterState.medConns, char.DescendantAdded:Connect(function(part)
if part:IsA("BasePart") then
table.insert(_G.AceCounterState.medConns, _G.AceOnMedusaAnchorChanged(part))
end
end))
end
function _G.AceStopMedCounter()
for _, c in pairs(_G.AceCounterState.medConns or {}) do
pcall(function() c:Disconnect() end)
end
_G.AceCounterState.medConns = {}
_G.AceCounterState.medDebounce = false
end
_G.AceBatCounterSlapList = {"Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap", "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap", "Nuclear Slap", "Galaxy Slap", "Glitched Slap"}
function _G.AceFindBatForCounter()
local c = LP.Character
if not c then return nil end
local bp = LP:FindFirstChildOfClass("Backpack") or LP:FindFirstChild("Backpack")
for _, name in ipairs(_G.AceBatCounterSlapList) do
local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name))
if t then return t end
end
for _, ch in ipairs(c:GetChildren()) do
if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
end
if bp then
for _, ch in ipairs(bp:GetChildren()) do
if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
end
end
return nil
end
function _G.AceSwingBatForCounter(bat, char)
if not bat or not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
if bat.Parent ~= char then
if hum then pcall(function() hum:EquipTool(bat) end) end
task.wait(0.05)
end
local remote = bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
if remote and remote:IsA("RemoteEvent") then
pcall(function() remote:FireServer() end)
task.wait(0.15)
pcall(function() remote:FireServer() end)
else
pcall(function() bat:Activate() end)
task.wait(0.15)
pcall(function() bat:Activate() end)
end
end
function _G.AceCounterIsRagdoll(hum)
if not hum then return false end
local st = hum:GetState()
return st == Enum.HumanoidStateType.Physics
or st == Enum.HumanoidStateType.Ragdoll
or st == Enum.HumanoidStateType.FallingDown
or hum.PlatformStand == true
end
function _G.AceStartBatCounter()
if _G.AceCounterState.batConn then return end
_G.AceCounterState.batDebounce = false
_G.AceCounterState.batConn = RunService.Heartbeat:Connect(function()
if not batCounterEnabled then return end
if _G.AceCounterState.batDebounce then return end
local char = LP.Character
if not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
if not hum then return end
if _G.AceCounterIsRagdoll(hum) then
_G.AceCounterState.batDebounce = true
task.spawn(function()
local bat = _G.AceFindBatForCounter()
if bat then _G.AceSwingBatForCounter(bat, char) end
task.wait(0.5)
_G.AceCounterState.batDebounce = false
end)
end
end)
end
function _G.AceStopBatCounter()
if _G.AceCounterState.batConn then
_G.AceCounterState.batConn:Disconnect()
_G.AceCounterState.batConn = nil
end
_G.AceCounterState.batDebounce = false
end
startBatCounter = _G.AceStartBatCounter
stopBatCounter = _G.AceStopBatCounter
setupMedusaCounter = _G.AceStartMedCounter
stopMedusaCounter = _G.AceStopMedCounter
_G.AceNoPlayerCollisionState = _G.AceNoPlayerCollisionState or {connections = {}}
function _G.AceSetOtherPlayerCollision(state)
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= LP and plr.Character then
for _, part in ipairs(plr.Character:GetDescendants()) do
if part:IsA("BasePart") then
pcall(function() part.CanCollide = state end)
end
end
end
end
end
function enableNoPlayerCollision()
if _G.AceNoPlayerCollisionState.runnin... (200 KB restante(s))
