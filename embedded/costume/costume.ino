// #define DEBUG 1

#include "debug.h"

#include <Adafruit_NeoPixel.h>
#include "strip.h"
#include "serial.h"

#define DELAY 100

Action* activeAction;

void setup() {
  strip.begin();
  strip.setBrightness(BRIGHTNESS);

  Bean.setBeanName(NAME);

  Serial.begin(9600);
  Serial.flush();

  strip.show();

  ppln("Setup complete");
}

void loop() {
  Action* newAction = getAction();
  if (newAction) {
    ppln("Got new action");
    if (activeAction) {
      while (activeAction->end()) {
        ppln("Waiting for previous action to complete");
        delay(DELAY);
      }
      delete activeAction;
      activeAction = NULL;
    }
    activeAction = newAction;
  }

  if (activeAction) {
    ppln("Ticking action");
    if (!activeAction->tick()) {
      ppln("Action complete");
      delete activeAction;
      activeAction = NULL;
    }
    strip.show();
    delay(DELAY);
  }
}
