#include "config.h"
#include "debug.h"

#include "globals.h"
#include <Adafruit_NeoPixel.h>
#include "strip.h"
#include "serial.h"

#define CLEAR_ACTIVE_ACTION() \
  delete activeAction;        \
  activeAction = NULL

#define DELAY() \
  show();       \
  delay(delayInterval)

#define SERIAL_BAUD_RATE 9600

Action* activeAction;

void setup() {
  strip.begin();
#ifdef BRIGHTNESS
  strip.setBrightness(BRIGHTNESS);
#endif

  Bean.setBeanName(NAME);

  Serial.begin(SERIAL_BAUD_RATE);
  Serial.flush();

  show();

  ppln("Setup complete");
}

void loop() {
  Action* newAction = getAction();
  if (newAction) {
    ppln("Got new action");
    if (activeAction) {
      while (activeAction->end()) {
        ppln("Waiting for previous action to complete");
        DELAY();
      }
      CLEAR_ACTIVE_ACTION();
    }
    activeAction = newAction;
  }

  if (activeAction) {
    ppln("Ticking action");
    if (!activeAction->tick()) {
      ppln("Action complete");
      CLEAR_ACTIVE_ACTION();
    }
    DELAY();
  }
}
