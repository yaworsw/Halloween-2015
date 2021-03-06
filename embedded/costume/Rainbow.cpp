#include "Rainbow.h"

Rainbow::Rainbow() {
  this->frames = NUM_PIXELS * 3;
  this->inc    = 255 / this->frames;
}

bool Rainbow::tick() {
  int pixel = this->frame % NUM_PIXELS;
  this->hue = (this->hue + this->inc) % 255;

  setPixelColor(pixel, Wheel(this->hue));
  this->frame++;

  if (this->frame > this->frames) {
    this->frame = 0;
  }

  return true;
}

bool Rainbow::end() {
  return false;
}
