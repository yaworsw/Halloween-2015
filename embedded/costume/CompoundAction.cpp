#include "CompoundAction.h"

CompoundAction::CompoundAction(Action* a1, Action* a2) {
  this->a1 = a1;
  this->a2 = a2;
};

CompoundAction::~CompoundAction() {
  delete this->a1;
  delete this->a2;
};

bool CompoundAction::tick() {
  if (!a1Done) {
    a1Done = !this->a1->tick();
  }
  if (!a2Done) {
    a2Done = !this->a2->tick();
  }
  if (a1Done && a2Done) {
    return false;
  } else {
    return true;
  }
};

bool CompoundAction::end() {
  if (!a1Done) {
    a1Done = !this->a1->end();
  }
  if (!a2Done) {
    a2Done = !this->a2->end();
  }
  if (a1Done && a2Done) {
    return false;
  } else {
    return true;
  }
};
