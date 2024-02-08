#ifndef CHARACTER_
#define CHARACTER_

#include <iostream>
#include <string>
#include <algorithm>

class Character {
  public:
    // constructor
    Character(std::string name, int attack, int health, int speed):name_{name}, attack_{attack}, health_{health}, speed_{speed} {}

    // output to console for debugging    
    void printCharacter() {
      std::cout << name_ << ":" << '\t' << "Atk:" << attack_ << '\t' << "HP:" << health_ << '\t' << "Spd:" << speed_ << std::endl;
    }

    void takeDamage(int damage) {
      health_ = std::max(health_ - damage, 0);
    }

    bool isAlive() {
      return (health_ > 0);
    }

    // character attributes
    const std::string name_;
    int attack_;
    int health_;
    int speed_;
};

#endif