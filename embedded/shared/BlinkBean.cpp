/**
 * BlinkBean.cpp
 *
 * This action simply blinks the LED of the bean.  Useful to debug which bean
 * you're interacting with and functions as a proof of concept for other action
 * implementations.
 */

#include "BlinkBean.h"

BlinkBean::BlinkBean(String params) {

};

bool BlinkBean::tick() {
  if (this->frame == 0) {
    Bean.setLed(255, 0, 0);
  } else if (this->frame > 200) {
    return this->off();
  }
  this->frame++;
  return true;
};

bool BlinkBean::off() {
  Bean.setLed(0, 0, 0);
  return false;
}
