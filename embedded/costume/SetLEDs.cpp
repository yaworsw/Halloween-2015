#include "SetLEDs.h"

SetLEDs::SetLEDs(byte hue) {
  this->hue = Wheel(hue);
}

bool SetLEDs::tick() {
  for (int i = 0; i < NUM_PIXELS; i++) {
    setPixelColor(i, this->hue);
  }

  return false;
}

bool SetLEDs::end() {
  return this->tick();
}
