# Devtronic SmartPendant

This project allows controlling a grblHAL based CNC machine without a PC. It also makes work way more convenient.

**Store:** https://devtronic.square.site/

![Image](Media/Devtronic_SmartPendant_1.png "Devtronic SmartPendant")
![Image](Media/Devtronic_SmartPendant_2.png "Devtronic SmartPendant")

# Firmware

Source code for this project can be found there: **https://github.com/nickshl/SmartPendant**

Latest firmware placed in Release folder: [SmartPendant.hex](https://github.com/nickshl/SmartPendant/blob/main/Release/SmartPendant.hex)

To load new firmware [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) is used.
Connect SmartPendant to PC using USB-C cable. Press and hold BOOT0 button, then short press NRST button, couple seconds later BOOT0 button can be released.
Open STM32CubeProgrammer. In top right corner choose "USB" from drop down list.
If field "Port" in "USB Configuration" show "No DFU detected" click update button near it.
Click "Connect" button - STM32CubeProgrammer should establish connection and show current device memory content.
Click "Open File" in left to corner, select firmware HEX file, then click "Download" button in top left corner.
When flashing is done, close STM32CubeProgrammer and short press NRST button on the Controller to restart it. 

**Note:** if flashing is successful, but firmware isn't work, check STM32CubeProgrammer log. If it says "sector 0000 does not exist" erasing operation wasn't successful and new firmware "merged"(write operation can only flip bits from 1 to 0) with old one. To fix this issue, press "eraser" button in bottom right corner and click "Ok" button in pop up window. After erasing is finished "Device memory" should show only FFFFFFFF. Flash new firmware after that. 

# PCB files

Files for PCB version 1.2: https://oshwlab.com/nick_shl/smart_pendant

# Parts

To make this project yourself, you will need these essential parts:

* [WeAct BlackPill F411 25M HSE:](https://s.click.aliexpress.com/e/_DC6TlGd)

* One of this displays:
  [3.5" Display with touchscreen based on ILI9488 LCD controller and FT6236 touch controller](https://www.aliexpress.us/item/3256804935586911.html) - select option ILI9488 FT6236
  [3.5" Display with touchscreen based on ILI9488 LCD controller and FT6236 touch controller](https://www.aliexpress.us/item/3256801122874433.html) - select option ILI9488 FT6236 or IPS ILI9488 FT6236(in my opinion regular looks better)
  [3.5" Display with touchscreen based on ILI9488 LCD controller and FT6236 touch controller](https://www.aliexpress.us/item/3256803764398718.html) - select option ILI9488 FT6236 or IPS ILI9488 FT6236(in my opinion regular looks better)

* [60 mm 6 pin 100 PPR handwheel](https://s.click.aliexpress.com/e/_DCFuJHr)

## Case

![Image](Media/Devtronic_SmartPendant_Case.png "Devtronic SmartPendant Case")

3D_Print folder of this repo contain 3D files(OpenSCAD and STLs) of the case. 

## Dimensions

**160** mm x **65** mm x **20** mm (55 mm with handwheel and handle)
Approx. 6-3/8" x 2-5/8" x 3/4"

## Schematic

Schematic vesion 1.3:
![Image](Media/Schematic_Smart_Pendant_v1_3.png "Devtronic SmartPendant Schematic")

Schematic vesion 1.1:
![Image](Media/Schematic_Smart_Pendant_v1_1.png "Devtronic SmartPendant Schematic")

## Firmware

Source code can be found [here](https://github.com/nickshl/SmartPendant)

