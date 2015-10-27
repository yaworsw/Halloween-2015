#ifndef ACTION_H
#define ACTION_H

class Action {
  public:
    virtual bool tick() = 0;
    virtual bool end()  = 0;
};

#endif //ACTION_H
