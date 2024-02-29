#include "Battler.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void Battler::_bind_methods() {
  ClassDB::bind_method(D_METHOD("getZars"), &Battler::getZars);
	ClassDB::bind_method(D_METHOD("setZars", "new_zars"), &Battler::setZars);
  ClassDB::add_property("Battler", PropertyInfo(Variant::ARRAY, "zars", PROPERTY_HINT_ARRAY_TYPE, "CharData", PROPERTY_USAGE_READ_ONLY), "setZars", "getZars");

  ClassDB::bind_method(D_METHOD("getTurnOrder"), &Battler::getTurnOrder);
	ClassDB::bind_method(D_METHOD("setTurnOrder", "new_turn_order"), &Battler::setTurnOrder);
  ClassDB::add_property("Battler", PropertyInfo(Variant::ARRAY, "turn_order", PROPERTY_HINT_ARRAY_TYPE, "int", PROPERTY_USAGE_READ_ONLY), "setTurnOrder", "getTurnOrder");

  ClassDB::bind_method(D_METHOD("printBattle"), &Battler::printBattle);
}

// constructor and destructor
Battler::Battler() {}
Battler::~Battler() {}
void Battler::_ready() {
  zars.resize(8);
}

// getters and setters
TypedArray<CharData> Battler::getZars() const {
  return zars;
}
void Battler::setZars(const TypedArray<CharData> new_zars) {
  zars = new_zars;
}

TypedArray<int> Battler::getTurnOrder() const {
  return turn_order;
}
void Battler::setTurnOrder(const TypedArray<int> new_turn_order) {
  turn_order = new_turn_order;
}

// print method for debug purposes
void Battler::printBattle() {
  Ref<CharData> ref_zars;
  for (int i = 0; i < zars.size(); ++i) {
    ref_zars = zars[i];
    if (ref_zars.is_null()) {
      UtilityFunctions::print("empty slot");
    }
    else {
      ref_zars->printCharacter();
    }
  }
  UtilityFunctions::print("Turn Order:", turn_order);
}