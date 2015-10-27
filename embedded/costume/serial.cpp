#include "serial.h"

String command = "";
String params  = "";

String tmpSerial = "";

Action* getAction() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    if (inChar == '\n') {

      int indexOfUnderscore = tmpSerial.indexOf('_');
      if (indexOfUnderscore > 0) {
        command = tmpSerial.substring(0, indexOfUnderscore);
        params  = tmpSerial.substring(indexOfUnderscore + 1);
      } else {
        command = tmpSerial;
        params  = "";
      }

      tmpSerial = "";

      if (command == "bb") {
        return new Identify();
      } else if (command == "rainbow") {
        return new Rainbow();
      } else if (command == "rainbow-all") {
        return new RainbowAll();
      }

    } else {
      tmpSerial += inChar;
    }
  }
  return NULL;
}
