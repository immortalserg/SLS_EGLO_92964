-- инициализация кнопки
obj.setScript("io.input0.value", "btn_sw1.lua", true)
gpio.addInput(33, gpio.INPUT_PULLUP, 2, "input0")
obj.set("led1b", 255)
-- статус светодиода автоматически
os.led("AUTO")