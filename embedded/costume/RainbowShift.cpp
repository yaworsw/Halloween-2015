#include "RainbowShift.h"

RainbowShift::RainbowShift() {
  this->inc = 255 / NUM_PIXELS;
}

bool RainbowShift::tick() {
  this->hue = (this->hue + this->inc) % 255;

  for (int i = 0; i < NUM_PIXELS; i++) {
    byte hue = (this->hue + (this->inc * i)) % 255;
    setPixelColor(i, Wheel(hue));
  }
  this->frame++;

  if (this->frame > NUM_PIXELS) {
    this->frame = 0;
  }

  return true;
}

bool RainbowShift::end() {
  return false;
}
