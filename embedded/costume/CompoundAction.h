#ifndef COMPOUND_ACTION_H
#define COMPOUND_ACTION_H

#include "Action.h"

class CompoundAction: public Action {
  public:
    CompoundAction(Action* a1, Action* a2);
    ~CompoundAction();
    bool tick();
    bool end();
  protected:
    Action* a1;
    Action* a2;

    bool a1Done = false;
    bool a2Done = false;
};

#endif //COMPOUND_ACTION_H
