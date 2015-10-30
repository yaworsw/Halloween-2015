#include "RainbowAll.h"

RainbowAll::RainbowAll() {
  this->frames = NUM_PIXELS * 3;
  this->inc    = 255 / this->frames;
}

bool RainbowAll::tick() {
  this->hue = (this->hue + this->inc) % 255;

  for (int i = 0; i < NUM_PIXELS; i++) {
    setPixelColor(i, Wheel(this->hue));
  }
  this->frame++;

  if (this->frame > this->frames) {
    this->frame = 0;
  }

  return true;
}

bool RainbowAll::end() {
  return false;
}
