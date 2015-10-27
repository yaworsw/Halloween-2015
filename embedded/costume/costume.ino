#include <Adafruit_NeoPixel.h>
#include "strip.h"
#include "serial.h"

#define DELAY 100

Action* activeAction;

void setup() {
  strip.begin();

  Bean.setBeanName(NAME);

  Serial.begin(9600);
  Serial.flush();

  strip.show();
}

void loop() {
  Action* newAction = getAction();
  if (newAction) {
    if (activeAction) {
      while (activeAction->end()) {
        delay(DELAY);
      }
      delete activeAction;
    }
    activeAction = newAction;
  }

  if (activeAction) {
    if (!activeAction->tick()) {
      delete activeAction;
    }
    strip.show();
    delay(DELAY);
  }
}
