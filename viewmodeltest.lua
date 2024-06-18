--[[
    Credits to:
    @flashintv..@Terminatormachine for helping me
    @10trips for adding proper item names
]]

--local font = draw.CreateFont("Tahoma", -11, 500, FONTFLAG_OUTLINE | FONTFLAG_CUSTOM)
--UnlitGeneric
local MenuLib = require("Menu")

local menumain = MenuLib.Create("Viewmodel v1.11 by wringly")

menumain:SetSize(300,800)
menumain.Style.Space = 4
menumain.Style.Font = draw.CreateFont("Verdana", 14, 510)
menumain.Style.Outline = true
menumain.Style.WindowBg = { 30, 30, 30, 200 }
menumain.Style.TitleBg = { 150, 50, 150, 255 }
menumain.Style.Text = { 255, 255, 255, 255 }
menumain.Style.Item = { 50, 50, 50, 255 }
menumain.Style.ItemHover = { 80, 65, 80, 255 }
menumain.Style.ItemActive = { 80, 80, 80, 255 }
menumain.Style.Highlight = { 180, 180, 180, 100 }


local basetextures = { -- textures added from tf2_textures_dir.vpk
    "vgui/white_additive",
    "patterns/paint_strokes",
    "patterns/paint_scratches",
    "brick/brickwall001",
    "brick/cobblewall001",
    "patterns/powerhouse/electric_blue"
}

local bumptextures = { -- textures added from tf2_textures_dir.vpk
    "vgui/white_additive",
    "patterns/paint_strokes",
    "patterns/paint_scratches",
    "brick/brickwall001",
    "brick/cobblewall001",
    "patterns/powerhouse/electric_blue"
}





menumain:AddComponent(MenuLib.Label("Viewmodel Settings"))

local basetexturebox = menumain:AddComponent(MenuLib.Combo("Base Texture", basetextures))
basetexturebox:Select(1)
local bumptexturebox = menumain:AddComponent(MenuLib.Combo("Bump Texture", bumptextures))
bumptexturebox:Select(1)

local frensel = menumain:AddComponent(MenuLib.Slider("Frensel", 0, 100, 100))
local seethrough = menumain:AddComponent(MenuLib.Checkbox("See-Through", true))
menumain:AddComponent(MenuLib.Label("Phong"))
local phong = menumain:AddComponent(MenuLib.Checkbox("Phong", true))

local phongx = menumain:AddComponent(MenuLib.Slider("PhongRangeX", 0, 100, 0))
local phongy = menumain:AddComponent(MenuLib.Slider("PhongRangeY", 0, 100, 5))
local phongz = menumain:AddComponent(MenuLib.Slider("PhongRangeZ", 0, 100, 10))


menumain:AddComponent(MenuLib.Label("SelfIllum"))
local selfillum = menumain:AddComponent(MenuLib.Checkbox("Selfillum", true))
--local selfillumfrensel = menumain:AddComponent(MenuLib.Slider("Selfillum Frensel(does nothing)", 0, 100, 100))

local selfillumfrenselx = menumain:AddComponent(MenuLib.Slider("selfillumfrenselRangeX", 0, 100, 49))
local selfillumfrensely = menumain:AddComponent(MenuLib.Slider("selfillumfrenselRangeY", 0, 100, 50))
local selfillumfrenselz = menumain:AddComponent(MenuLib.Slider("selfillumfrenselRangeZ", 0, 100, 0))

local selfillumR = menumain:AddComponent(MenuLib.Slider("selfillumR", 0, 100, 5))
local selfillumG = menumain:AddComponent(MenuLib.Slider("selfillumG", 0, 100, 5))
local selfillumB = menumain:AddComponent(MenuLib.Slider("selfillumB", 0, 100, 5))


menumain:AddComponent(MenuLib.Label("Color"))
local r = menumain:AddComponent(MenuLib.Slider("R", 0, 100, 5))
local g = menumain:AddComponent(MenuLib.Slider("G", 0, 100, 5))
local b = menumain:AddComponent(MenuLib.Slider("B", 0, 100, 50))

-- have not figured this out :(
--menumain:AddComponent(MenuLib.Label("Animation"))
--local rotatespeed = menumain:AddComponent(MenuLib.Slider("Rotation Speed", -100, 100, 0))
--local directionx = menumain:AddComponent(MenuLib.Slider("Direction X", -100, 100, 0))
--local directiony = menumain:AddComponent(MenuLib.Slider("Direction Y", -100, 100, 0))

--pls
local frenselval 
--if frensel:GetValue() == true then frenselval = "1" else frenselval = "0" end
local seethroughval 
local phongval 

local phongxval 
local phongyval 
local phongzval 

local selfillumval 

local selfillumfrenselval 

local selfillumfrenselxval
local selfillumfrenselyval 
local selfillumfrenselzval 

local selfillumRval 
local selfillumGval 
local selfillumBval 

local rval
local gval 
local bval 

local basetextureselect
local bumptextureselect

--local rotatespeedval = 0
local rotateincrement = 0
--local directionxval
--local directionyval



local kv = [["VertexLitGeneric"
        {
            $basetexture "vgui/white_additive"
            $bumpmap "models/player/shared/shared_normal"
            $envmap "skybox/sky_dustbowl_01"
            $envmapfresnel "1"
            $ignorez "1"
            $phong "1"
            $phongfresnelranges "[0 0.05 0.1]"
            $selfillum "1"
            $selfillumfresnel "1"
            $selfillumfresnelminmaxexp "[0.4999 0.5 0]"
            $envmaptint "[ .5 .05 0.5 ]"
            $selfillumtint "[ 0.03 0.03 0.03 ]"
            
        }
        ]]

--[[kv = [["UnlitGeneric"
    {   
        
        "$basetexture"  "vgui/white_additive"
        "$ignorez" "1"
        "$model" "1"
        "$translucent" "true"
    }
    ]]

myMaterial = materials.Create( "myMaterial", kv )

local function update()
    kv = [["VertexLitGeneric"
        {
            $basetexture "]]..basetextureselect..[["
            $basetexturetransform "center .5 .5 scale 3 3 rotate ]]..rotateincrement..[[ translate 0 0"
            $bumpmap "]]..bumptextureselect..[["
            $envmap "skybox/sky_dustbowl_01"
            $envmapfresnel "]]..frenselval..[["
            $ignorez "]]..seethroughval..[["
            $phong "]]..phongval..[["
            $phongfresnelranges "[]]..phongxval.." "..phongyval.." "..phongzval..[[]"
            $selfillum "]]..selfillumval..[["
            $selfillumfresnel "]]..selfillumfrenselval..[["
            $selfillumfresnelminmaxexp "[]]..selfillumfrenselxval.." "..selfillumfrenselyval.." "..selfillumfrenselzval..[[]"
            $envmaptint "[]]..rval.." "..gval.." "..bval..[[]"
            $selfillumtint "[]]..selfillumRval.." "..selfillumGval.." "..selfillumBval..[[]"
            
        }
        ]]


        myMaterial = materials.Create( "myMaterial", kv )
end


local function refresh()
    frenselval = tostring(frensel:GetValue()/100)
    --if frensel:GetValue() == true then frenselval = "1" else frenselval = "0" end
    seethroughval = "1"
    if seethrough:GetValue() == true then seethroughval = "1" else seethroughval = "0" end
    phongval = "1"
    if phong:GetValue() == true then phongval = "1" else phongval = "0" end

    phongxval = tostring(phongx:GetValue()/100)
    phongyval = tostring(phongy:GetValue()/100)
    phongzval = tostring(phongz:GetValue()/100)

    selfillumval = "1"
    if selfillum:GetValue() == true then selfillumval = "1" else selfillumval = "0" end

    selfillumfrenselval = "1"

    selfillumfrenselxval = tostring(selfillumfrenselx:GetValue()/100)
    selfillumfrenselyval = tostring(selfillumfrensely:GetValue()/100)
    selfillumfrenselzval = tostring(selfillumfrenselz:GetValue()/100)

    selfillumRval = tostring(selfillumR:GetValue()/100)
    selfillumGval = tostring(selfillumG:GetValue()/100)
    selfillumBval = tostring(selfillumB:GetValue()/100)

    rval = tostring(r:GetValue()/100)
    gval = tostring(g:GetValue()/100)
    bval = tostring(b:GetValue()/100)

    basetextureselect = basetextures[basetexturebox:GetSelectedIndex()]
    bumptextureselect = bumptextures[bumptexturebox:GetSelectedIndex()]

    --rotatespeedval = tostring(rotatespeed:GetValue())
    --directionxval = tostring(directionx:GetValue())
    --directionyval = tostring(directiony:GetValue())

    update()
end

local function configSave()

    print("duide")
    local finalstr = ";frensval:"..frenselval
    finalstr = finalstr..";seethroughval:"..seethroughval
    finalstr = finalstr..";phongval:"..phongval

    finalstr = finalstr..";phongxval:"..phongxval
    finalstr = finalstr..";phongyval:"..phongyval
    finalstr = finalstr..";phongzval:"..phongzval

    finalstr = finalstr..";selfillumval:"..selfillumval
    finalstr = finalstr..";selfillumfrenselval:"..selfillumfrenselval

    finalstr = finalstr..";selfillumfrenselxval:"..selfillumfrenselxval
    finalstr = finalstr..";selfillumfrenselxval:"..selfillumfrenselyval
    finalstr = finalstr..";selfillumfrenselxval:"..selfillumfrenselzval

    finalstr = finalstr..";selfillumRval:"..selfillumRval
    finalstr = finalstr..";selfillumGval:"..selfillumGval
    finalstr = finalstr..";selfillumBval:"..selfillumBval

    finalstr = finalstr..";rval:"..rval
    finalstr = finalstr..";gval:"..gval 
    finalstr = finalstr..";bval:"..bval 

    finalstr = finalstr..";basetextureselect:"..basetextureselect
    finalstr = finalstr..";bumptextureselect:"..bumptextureselect

    finalstr = finalstr..";rotatespeedval:"..rotatespeedval
    finalstr = finalstr..";directionxval:"..directionxval
    finalstr = finalstr..";directionyval:"..directionyval



    -- this is located in your tf2 directory! V
    file = io.open("ViewmodelConfig.txt", "w")
    if file == nil then print("FILE IS NIL!") return end
    file:write(finalstr)
    file:close()



end

local function configLoad()
    file = io.open("ViewmodelConfig.txt", "r")
    if file == nil then print("FILE TO LOAD IS NIL!") return end

    local content = file:read "*a"

    --print(content)

    function splitStringByDelimiter(inputStr, delimiter)
        local result = {}
        local pattern = string.format("([^%s]+)", delimiter)
        for word in string.gmatch(inputStr, pattern) do
            table.insert(result, word)
        end
        return result
    end

    for i, entry in ipairs(splitStringByDelimiter(content, ";")) do -- split all the data
        local entrydata = splitStringByDelimiter(entry, ":") -- split the "variable:data"

        local variable = entrydata[1]
        local stored = entrydata[2]

        print(variable, stored)

        if variable == "frenselval" then
            frenselval = stored
            -- this is where you add "set value of ui component"
        elseif variable == "seethroughval" then
            seethroughval = stored

        elseif variable == "phongval" then
            phongval = stored

        elseif variable == "phongxval" then
            phongxval = stored
        elseif variable == "phongyval" then
            phongyval = stored
        elseif variable == "phongzval" then
            phongzval = stored

        elseif variable == "selfillumval" then
            selfillumval = stored

        elseif variable == "selfillumfrenselval" then
            selfillumfrenselval = stored

        elseif variable == "selfillumfrenselxval"then
            selfillumfrenselxval = stored
        elseif variable == "selfillumfrenselyval" then
            selfillumfrenselyval = stored
        elseif variable == "selfillumfrenselzval" then
            selfillumfrenselzval = stored

        elseif variable == "selfillumRval" then
            selfillumRval = stored
        elseif variable == "selfillumGval" then
            selfillumGval = stored
        elseif variable == "selfillumBval" then
            selfillumBval = stored

        elseif variable == "rval" then
            rval = stored
        elseif variable == "gval" then
            gval = stored
        elseif variable == "bval" then
            bval = stored

        elseif variable == "basetextureselect" then
            basetextureselect = stored
        elseif variable == "bumptextureselect" then
            bumptextureselect = stored

        elseif variable == "rotatespeedval" then
            rotatespeedval = stored
        elseif variable == "directionxval" then
            directionxval = stored
        elseif variable == "directionyval" then
            directionyval = stored


        end
        
     end

     update()

     print(rval,gval,bval)


end

local refreshbutton = menumain:AddComponent(MenuLib.Button("Refresh", refresh))
refresh()


local saveconfigbutton = menumain:AddComponent(MenuLib.Button("Save Config", configSave))
local loadconfigbutton = menumain:AddComponent(MenuLib.Button("Load Config", configLoad))

local function onDraw(DrawModelContext)
    --rotateincrement = rotateincrement + rotatespeedval

    local pEntity = DrawModelContext:GetEntity()

    if pEntity == nil then return end

    if pEntity:GetClass() == "CTFViewModel" then
        DrawModelContext:ForcedMaterialOverride(myMaterial) 
    end
end

local function Unload()
    MenuLib.RemoveMenu(menumain)
end 

callbacks.Unregister( "DrawModel", "viewModelDraw", onDraw)
callbacks.Register( "DrawModel", "viewModelDraw", onDraw )

callbacks.Unregister("Unload", "MT_Unload") 
callbacks.Register("Unload", "MT_Unload", Unload)