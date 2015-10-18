/**
 * costume.ino
 *
 * The sketch for the arduino.  It's renamed by the script/install script to
 * match the name of the directory it's being put into.
 */

#include "custom.h"

#include <Adafruit_NeoPixel.h>

#include "serial.h"
#include "actions.h"

#define LOOP_DELAY               50
#define CURRENT_ACTION_OFF_DELAY 50

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);
serialEvent* msg;
Action* currentAction;

void setup() {
  Bean.setBeanName(NAME);

  Serial.begin(9600);
  Serial.flush();
  pixels.begin();
}

void loop() {
  if (readSerial(msg)) { // readSerial returns true if we parsed a new serial message
    if (currentAction) {
      while (currentAction->off()) {
        delay(CURRENT_ACTION_OFF_DELAY);
      }
      delete currentAction;
    }

    switch (msg->type) {
      case BLINK_BEAN:
        currentAction = new BlinkBean(msg->params);
        break;
    }

  } else {
    if (currentAction) {
      if (!currentAction->tick()) {
        delete currentAction;
      }
      delay(LOOP_DELAY);
    }
  }
}
