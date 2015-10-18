/**
 * serial.cpp
 *
 * Implements readSerial which parses input from Serial.
 */

#include "serial.h"

String type      = "";
String params    = "";
bool parsingType = true;

//
// readSerial
//
// Reads input from Serial and returns true when a complete message as been
// received.
//

bool readSerial(serialEvent* event) {
  while (Serial.available()) {
    char inChar = (char)Serial.read();

    // check for delimiters
    if (inChar == '_') {
      parsingType = false;
      continue;
    } else if (inChar == '\n') {
      parsingType = true;
      Serial.flush();

      delete event;
      event         = new serialEvent();
      event->type   = type.toInt();
      event->params = params;

      type   = "";
      params = "";

      return true;
    }

    (parsingType ? type : params) += inChar;
  }
  return false;
}
