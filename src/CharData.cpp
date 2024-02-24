#include "CharData.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void CharData::_bind_methods() {
  ClassDB::bind_method(D_METHOD("getName"), &CharData::getName);
	ClassDB::bind_method(D_METHOD("setName", "name"), &CharData::setName);
	ClassDB::add_property("CharData", PropertyInfo(Variant::STRING, "name"), "setName", "getName");

  ClassDB::bind_method(D_METHOD("getAttack"), &CharData::getAttack);
  ClassDB::bind_method(D_METHOD("setAttack", "attack"), &CharData::setAttack);
  ClassDB::add_property("CharData", PropertyInfo(Variant::INT, "attack"), "setAttack", "getAttack");

  ClassDB::bind_method(D_METHOD("getHealth"), &CharData::getHealth);
  ClassDB::bind_method(D_METHOD("setHealth", "health"), &CharData::setHealth);
  ClassDB::add_property("CharData", PropertyInfo(Variant::INT, "health"), "setHealth", "getHealth");

  ClassDB::bind_method(D_METHOD("getSpeed"), &CharData::getSpeed);
  ClassDB::bind_method(D_METHOD("setSpeed", "speed"), &CharData::setSpeed);
  ClassDB::add_property("CharData", PropertyInfo(Variant::INT, "speed"), "setSpeed", "getSpeed");

  ClassDB::bind_method(D_METHOD("getAnimation"), &CharData::getAnimation);
  ClassDB::bind_method(D_METHOD("setAnimation", "anim"), &CharData::setAnimation);
  ClassDB::add_property("CharData", PropertyInfo(Variant::OBJECT, "sprite_frames", PROPERTY_HINT_RESOURCE_TYPE, "SpriteFrames"), "setAnimation", "getAnimation");

  ClassDB::bind_method(D_METHOD("printCharacter"), &CharData::printCharacter);
}

// constructor and destructor
CharData::CharData() {
  name_ = "";
  attack_ = 0;
  health_ = 0;
  speed_ = 0;
}
CharData::~CharData() {}

// getters and setters
String CharData::getName() const {
  return name_;
}
void CharData::setName(const String name) {
  name_ = name;
}

int CharData::getAttack() const {
  return attack_;
}
void CharData::setAttack(const int attack) {
  attack_ = attack;
}

int CharData::getHealth() const {
  return health_;
}
void CharData::setHealth(const int health) {
  health_ = health;
}

int CharData::getSpeed() const {
  return speed_;
}
void CharData::setSpeed(const int speed) {
  speed_ = speed;
}

Ref<SpriteFrames> CharData::getAnimation() const {
  return animation_;
}
void CharData::setAnimation(const Ref<SpriteFrames> anim) {
  animation_ = anim;
}

// print method for debug purposes
void CharData::printCharacter() {
  UtilityFunctions::print(name_ + ":\tatk:" + String::num_int64(attack_) + "\thp:" + String::num_int64(health_) + "\tspd:" + String::num_int64(speed_));
}