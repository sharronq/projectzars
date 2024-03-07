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

  ClassDB::bind_method(D_METHOD("startBattle"), &Battler::startBattle);
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

// member functions for back end
void Battler::findTurnOrder() {
  turn_order.clear();
  Ref<CharData> ref_zars;
  int order;
  for (int i = 0; i < zars.size(); ++i) {
    ref_zars = zars[i];
    if (!ref_zars.is_null()) {
      turn_order.push_back((ref_zars->getSpeed() * zars.size()) + i);
    }
  }
  turn_order.sort();
  turn_order.reverse();
  // turn_order.sort_custom(); // doesnt work with c++
  for (int i = 0; i < turn_order.size(); ++i) {
    order = turn_order[i];
    turn_order[i] = order % zars.size();
  }
}

int Battler::getEnemyOf(const int attacker) const {
  int start;
  Ref<CharData> ref_zars;
  TypedArray<int> enemies;
  if (attacker < zars.size() / 2) {
    start = zars.size() / 2;
  }
  else {
    start = 0;
  }
  for (int i = start; i < start + zars.size() / 2; ++i) {
    ref_zars = zars[i];
    if (!ref_zars.is_null()) {
      enemies.push_back(i);
    }
  }
  return enemies.pick_random();
}

// member functions that are exported
void Battler::startBattle() {
  team_a = team_b = 0;
  Ref<CharData> ref_zars;
  for (int i = 0; i < zars.size() / 2; ++i) {
    ref_zars = zars[i];
    if (!ref_zars.is_null()) {
      team_a++;
    }
  }
  for (int i = zars.size() / 2; i < zars.size(); ++i) {
    ref_zars = zars[i];
    if (!ref_zars.is_null()) {
      team_b++;
    }
  }
  findTurnOrder();
  current_turn = 0;
  UtilityFunctions::print("Team count: ", team_a, ", ", team_b);
}

void Battler::playNextTurn() {
  if (team_a == 0 || team_b == 0) {
    return;
  }
  int attacker = turn_order[current_turn];
  int victim = getEnemyOf(attacker);
  UtilityFunctions::print("Turn ", current_turn, ": Attacker slot ", attacker, " attacked victim slot ", victim);
  Ref<CharData> ref_attacker = zars[attacker];
  Ref<CharData> ref_victim = zars[victim];
  ref_victim->setHealth(ref_victim->getHealth() - ref_attacker->getAttack());
  if (ref_victim->getHealth() <= 0) {
    UtilityFunctions::print("Victim slot ", victim, " died!");
    zars[victim].clear();
    int victim_order = turn_order.find(victim);
    turn_order.remove_at(victim_order);
    if (victim_order < current_turn) {
      current_turn--;
    }
    if (victim < zars.size() / 2) {
      team_a--;
    }
    else {
      team_b--;
    }
    UtilityFunctions::print("Team count: ", team_a, ", ", team_b);
  }
  current_turn = (current_turn + 1) % turn_order.size();
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