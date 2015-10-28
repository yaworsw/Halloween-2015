#include "serial.h"

String command = "";
String params  = "";

String tmpSerial = "";

Action* getAction() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    if (inChar == '\n') {
      Serial.flush();

      int indexOfUnderscore = tmpSerial.indexOf('_');
      if (indexOfUnderscore > 0) {
        command = tmpSerial.substring(0, indexOfUnderscore);
        params  = tmpSerial.substring(indexOfUnderscore + 1);
      } else {
        command = tmpSerial;
        params  = "";
      }

      tmpSerial = "";

      Serial.println(command);

      if (command == "bb") {
        return new Identify();
      } else if (command == "rainbow") {
        return new Rainbow();
      } else if (command == "rainbow-all") {
        return new RainbowAll();
      } else if (command == "rainbow-shift") {
        return new RainbowShift();
      } else if (command == "set-leds") {
        return new SetLEDs(params.toInt());
      }

    } else {
      tmpSerial += inChar;
    }
  }
  return NULL;
}
