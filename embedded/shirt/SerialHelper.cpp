/**
 * SerialHelper.cpp
 */

#include "SerialHelper.h"

SerialHelper::SerialHelper() {

}

bool SerialHelper::readLine() {
  if (this->newLine) {
    this->line = "";
    this->newLine = false;
  }

  while (Serial.available()) {
    char inChar = (char)Serial.read();
    if (inChar == '\n') {
      this->newLine = true;
      return true;
    } else {
      this->line += inChar;
    }
  }

  return false;
}

int SerialHelper::getCommand() {
  return this->line.toInt();
}

String SerialHelper::getParams() {
  int firstUnderscore = this->line.indexOf('_');
  return this->line.substring(firstUnderscore + 1);
}
