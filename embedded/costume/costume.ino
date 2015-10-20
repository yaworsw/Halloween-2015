#include <Adafruit_NeoPixel.h>
#include "config.h"

String prevCommand = "";
String prevParams  = "";

String command = "";
String params  = "";

String tmpSerial = "";

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_PIXELS, PIXEL_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  strip.begin();

  Bean.setBeanName(NAME);

  Serial.begin(9600);
  Serial.flush();

  strip.show();
}

bool getSerialUpdates() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    if (inChar == '\n') {
      prevCommand = command;
      prevParams  = params;

      int indexOfUnderscore = tmpSerial.indexOf('_');
      if (indexOfUnderscore > 0) {
        command = tmpSerial.substring(0, indexOfUnderscore);
        params  = tmpSerial.substring(indexOfUnderscore + 1);
      } else {
        command = tmpSerial;
        params  = "";
      }

      tmpSerial = "";

      Serial.print("Returning true with command: ");
      Serial.println(command);
      Serial.print("And params: ");
      Serial.println(params);

      return true;
    } else {
      tmpSerial += inChar;
    }
  }
  return false;
}

// rainbow
int rainbow_inc = 255 / (NUM_PIXELS * 3);
int rainbow_h   = 0;
int rainbow_i   = 0;

void loop() {
  if (getSerialUpdates()) {
  }

  if (command == "") {                                                          // noop
    return;
  } else {

    Serial.print("Running command: ");
    Serial.println(command);
    Serial.print("With params: ");
    Serial.println(params);

    if (command == "bb") {                                                      // blink bean
      Bean.setLed(255, 0, 0);
      delay(500);
      Bean.setLed(0, 0, 0);
      command = "";
    } else if (command == "rainbow") {                                          // rainbow
      rainbow_h += rainbow_inc;
      if (rainbow_h > 255) rainbow_h = 0;

      strip.setPixelColor(rainbow_i++, Wheel(rainbow_h));
      strip.show();

      if (rainbow_i > NUM_PIXELS) rainbow_i = 0;

      if (params != "") {
        delay(params.toInt());
      } else {
        delay(200);
      }

    } else if (command == "all-rainbow") {                                      // all-rainbow
      rainbow_h += rainbow_inc;
      if (rainbow_h > 255) rainbow_h = 0;

      for (int i = 0; i < NUM_PIXELS; i++) {
        strip.setPixelColor(i, Wheel(rainbow_h));
      }
      strip.show();

      if (params != "") {
        delay(params.toInt());
      } else {
        delay(200);
      }
    }
  }
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  } else {
   WheelPos -= 170;
   return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  }
}
