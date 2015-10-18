/**
 * Action.h
 *
 * Defines the base Action class for all actions the costume can do.
 */

#ifndef ACTION_H
#define ACTION_H

#include <Arduino.h>

/**
 * Action class
 *
 * The Action class is the root class for all actions the costume can do.
 */

class Action {
  public:

    //
    // Action::tick
    //
    // Plays the next frame of the animation.  If there are no frames left to
    // play then return false.
    //

    virtual bool tick() = 0;

    //
    // Action::off
    //
    // Plays the last frame of the animation.  If this method returns true then
    // it will be called over and over until it returns false thus signifying
    // that this action is complete.
    //

    virtual bool off()  = 0;

  protected:
    int frame = 0;

};

/**
 * DEF_ACTION macro
 *
 * This macro allows us to quickly and easily define a standard class that
 * extends Action.
 */

#define DEF_ACTION(name) \
  class name: public Action { \
    public:                   \
      name(String params);    \
      bool tick();            \
      bool off();             \
    protected:                \
      int frame = 0;          \
  };

#endif //ACTION_H
