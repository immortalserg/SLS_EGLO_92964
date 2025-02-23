-- функции
-- Curtain_up (f_name), Curtain_down (f_name) - рольставни вниз/вверх параметр - FrendlyName рольставни
-- Рольставни вверх/останов
function Curtain_up (f_name)
  zigbee.get(f_name, "moving")
  local moving = zigbee.value(f_name, "moving")
  if (moving=="UP" or moving=="DOWN") then
    zigbee.set(f_name, "state", "STOP")
  else
    zigbee.set(f_name, "state", "UP")
  end
end
-- Рольставни вниз/останов
function Curtain_down (f_name)
  zigbee.get(f_name, "moving")
  local moving = zigbee.value(f_name, "moving")
  if (moving=="UP" or moving=="DOWN") then
    zigbee.set(f_name, "state", "STOP")
  else
    zigbee.set(f_name, "state", "DOWN")
  end
end
-- Рольставниреверс/останов
function Curtain_revers (f_name)
  zigbee.get(f_name, "moving")
  zigbee.get(f_name, "position")
  local moving = zigbee.value(f_name, "moving")
  local position = zigbee.value(f_name, "position")
  if (moving=="UP" or moving=="DOWN") then
    zigbee.set(f_name, "state", "STOP")
  else
    if (position==0) then
      zigbee.set(f_name, "state", "UP")
    else
      zigbee.set(f_name, "state", "DOWN")
    end
  end
end

-- btn_name   - Имя выключателя
-- btn_state  - статус команды (single, double ...)
-- type       - тип устройства которое управляется (Switch, Curtain)
-- obj_name   - имя устройства которым управлять
-- obj_status - статус свойства (для Curtain - UP, DOWN, TOGGLE)
-- obj_state  - имя свойства (для Curtain не используется)
 
 
function switch (btn_name, btn_state, type, obj_name, obj_status, obj_state)
  local name=Event.FriendlyName -- имя выключателя который нажат
  local btn=zigbee.value(tostring(Event.ieeeAddr), "action") -- событие кнопки
  if (name==btn_name and btn==btn_state) then 
    if type == "Switch" then
      zigbee.set(obj_name, obj_state, obj_status)
    end
    if type == "Curtain" then
      if obj_status=="UP" then
          zigbee.get(obj_name, "moving")
          local moving =  zigbee.value(obj_name, "moving")
          if (moving=="UP" or moving=="DOWN") then 
            zigbee.set(obj_name, "state", "STOP")
          else 
            zigbee.set(obj_name, "state", "UP")
          end
      end
      if obj_status=="DOWN" then
          zigbee.get(obj_name, "moving")
          local moving =  zigbee.value(obj_name, "moving")
          if (moving=="UP" or moving=="DOWN") then 
            zigbee.set(obj_name, "state", "STOP")
          else 
            zigbee.set(obj_name, "state", "DOWN")
          end
      end     
      if obj_status=="TOGGLE" then   
        zigbee.get(obj_name, "moving")
        local moving = zigbee.value(obj_name, "moving")
        zigbee.get(obj_name, "position")
        local position = zigbee.value(obj_name, "position")
        if (moving=="UP" or moving=="DOWN") then
          zigbee.set(obj_name, "state", "STOP")
        else
          if (position==0) then
            zigbee.set(obj_name, "state", "UP")
          else
            zigbee.set(obj_name, "state", "DOWN")
          end
        end
      end   
    end
end
end
-- для управления диммером (включение на заданную яркост/выключение)
-- btn_name   - Имя выключателя
-- btn_state  - какая команда выключателя (single, double, right, left ...)
-- obj_name   - имя диммера которым управлять
-- obj_status - номер канала (для state_l1 должно быть "_l1", для state должно быть "")
-- obj_state  - значение диммера
function dimmer (btn_name, btn_state, obj_name, obj_num, obj_state)
  local name=Event.FriendlyName -- имя выключателя который нажат
  local btn=zigbee.value(tostring(Event.ieeeAddr), "action") -- событие кнопки
  if (name==btn_name and btn==btn_state) then 
    zigbee.get(obj_name, "state" .. obj_num)
    local state =  zigbee.value(obj_name, "state" .. obj_num)
    if state == "ON" then
      zigbee.set(obj_name, "state" .. obj_num, "OFF")
    else
      zigbee.set(obj_name, "brightness" .. obj_num, obj_state)
    end
  end
end