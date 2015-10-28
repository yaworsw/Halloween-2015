#include <Arduino.h>
#include "Action.h"
#include "config.h"
#include "strip.h"

class SetLEDs: public Action {
  public:
    SetLEDs(byte hue);
    bool tick();
    bool end();
  protected:
    uint32_t hue;
};
