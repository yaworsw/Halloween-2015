#include <Arduino.h>
#include "Action.h"

class Identify: public Action {
  public:
    Identify();
    bool tick();
    bool end();
};
