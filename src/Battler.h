#ifndef BATTLER_
#define BATTLER_

#include <godot_cpp/classes/node2d.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include "CharData.h"

namespace godot {

class Battler : public Node2D {
  GDCLASS(Battler, Node2D)

private:
  TypedArray<CharData> zars;
  TypedArray<int> turn_order;

protected:
  static void _bind_methods();

public:
  // constructor and destructor
  Battler();
  ~Battler();
  void _ready() override;

  // getters and setters
  TypedArray<CharData> getZars() const;
  void setZars(const TypedArray<CharData> new_zars);

  TypedArray<int> getTurnOrder() const;
  void setTurnOrder(const TypedArray<int> new_turn_order);

  // print method for debug purposes
  void printBattle();
};

}

#endif