#ifndef CHAR_DATA_
#define CHAR_DATA_

#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/classes/sprite_frames.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

namespace godot {

class CharData : public Resource {
  GDCLASS(CharData, Resource)

private:
  String name_;
  int attack_;
  int health_;
  int speed_;
  Ref<SpriteFrames> animation_;

  int current_health;

protected:
  static void _bind_methods();

public:
  // constructor and destructor
  CharData();
  ~CharData();

  // getters and setters
  String getName() const;
  void setName(const String name);

  int getAttack() const;
  void setAttack(const int attack);

  int getHealth() const;
  void setHealth(const int health);

  int getSpeed() const;
  void setSpeed(const int speed);

  Ref<SpriteFrames> getAnimation() const;
  void setAnimation(const Ref<SpriteFrames> anim);

  int getCurrentHealth() const;
  void setCurrentHealth(const int new_current);

  // print method for debug purposes
  void printCharacter();
};
}

#endif