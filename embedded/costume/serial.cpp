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

      pp("Received command: ");
      ppln(command);

      if (command == "bb") {
        return new Identify();
      } else if (command == "off") {
        return new Off();
      } else if (command == "rainbow") {
        return new Rainbow();
      } else if (command == "rainbow-all") {
        return new RainbowAll();
      } else if (command == "rainbow-shift") {
        return new RainbowShift();
      } else if (command == "set-leds") {
        return new SetLEDs(params.toInt());
      } else {
        //
        // These don't return actions.  Instead they take some immediate effect
        // mostly used to do some sort of configuration.
        //
        if (command == "change-delay") {
          delayInterval = params.toInt();
        } else if (command == "set-bri") {
          strip.setBrightness(params.toInt());
        }
        return NULL;
      }

    } else {
      tmpSerial += inChar;
    }
  }
  return NULL;
}
