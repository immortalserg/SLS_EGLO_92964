-- нажатие кнопки
if Event.Obj.Value == "single" then
  -- однократное нажатие кнопки
  if obj.get("led1") == "ON" then
  	obj.set("led1", "AUTO")
  	os.led("AUTO")
  else
  	obj.set("led1", "ON")
  	os.led("ON",obj.get("led1b"),-1,-1,-1,0)
  end
elseif Event.Obj.Value == "double" then
  -- двухкратное нажатие кнопки
  if obj.get("led1") == "ON" then
    bri = obj.get("led1b")
    bri = bri + 20
    if bri > 250 then 
      bri = 20 
    end
    obj.set("led1b", bri)
    os.led("ON",obj.get("led1b"),-1,-1,-1,0)
  end
elseif Event.Obj.Value == "triple" then  
  -- трехкратное нажатие кнопки
    print ("ТРЫ")
    os.led("AUTO")
	zigbee.join(10, "0x0000")
else
  return
end