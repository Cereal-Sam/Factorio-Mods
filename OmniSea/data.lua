--Set triggers
if not omni then omni = {} end
if not omni.sea then omni.sea = {} end

if data.raw.technology["sct-automation-science-pack"] then
    omni.sea.tech4 = "sct-automation-science-pack"
else
    omni.sea.tech4 = "sb-startup4"
end

require("prototypes.buildings")
require("prototypes.categorys")
require("prototypes.items")
require("prototypes.recipes")

--Remove Coal from the Omnimatter table to disable all Coal extractions 
omni.remove_resource("coal")
