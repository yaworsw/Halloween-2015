/**
 * shirt.ino
 */

#include "custom.h"

#include <Adafruit_NeoPixel.h>

#include "actions.h"
#include "SerialHelper.h"

#define LOOP_DELAY               10
#define CURRENT_ACTION_OFF_DELAY 10

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);
SerialHelper serialHelper;
Action* activeAction;

void setup() {
  Bean.setBeanName(NAME);

  Serial.begin(9600);
  Serial.flush();
  pixels.begin();

  serialHelper = SerialHelper();
}

void loop() {
  if (serialHelper.readLine()) {

    // if there is an active action when we get a new command then call it until it completes
    if (activeAction) {
      while (activeAction->off()) {
        delay(CURRENT_ACTION_OFF_DELAY);
      }
      delete activeAction;
    }

    // create a new action
    Serial.println(serialHelper.getCommand());
    switch (serialHelper.getCommand()) {
      case BLINK_BEAN:
        activeAction = new BlinkBean(serialHelper.getParams());
        break;
    }

  } else {

    // if we did not get a new command from serial then move onto the next frame of the
    if (activeAction) {
      if (!activeAction->tick()) {
        delete activeAction;
      }
      delay(LOOP_DELAY);
    }

  }
}
