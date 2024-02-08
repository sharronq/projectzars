#ifndef BATTLER_
#define BATTLER_

#include <iostream>
#include <vector>
#include "Character.h"
#include <algorithm>

class Battler {
  public:
    // constructor
    Battler() {};
    Battler(std::vector<Character> team_a, std::vector<Character> team_b);

    // function to find turn order
    void findTurnOrder();

    // prints out the characters in battle
    void printBattle();

    // prints the turn order
    void printTurnOrder();

    // battle details
    std::vector<Character> chrs_;
    int no_team_a_;
    int no_team_b_;
    std::vector<int> turn_order_;
};

Battler::Battler(std::vector<Character> team_a, std::vector<Character> team_b) {
  no_team_a_ = team_a.size();
  no_team_b_ = team_b.size();

  for (auto chr : team_a) {
    chrs_.push_back(chr);
  }
  for (auto chr : team_b) {
    chrs_.push_back(chr);
  }
}

void Battler::findTurnOrder() {
  // add speeds and index to turn order
  for (int i = 0; i < chrs_.size(); i++) {
    int speed = (chrs_[i].speed_ * 10) + i;
    turn_order_.push_back(speed);
  }
  // sort turn order in descending order
  std::sort (turn_order_.begin(), turn_order_.end(), std::greater<int>());
  // remove speed leaving only indexes
  for (int& value : turn_order_) {
    value = value % 10;
  }
}

void Battler::printBattle() {
  for (int i = 0; i < no_team_a_; i++) {
    chrs_[i].printCharacter();
  }
  std::cout << std::endl;
  for (int i = no_team_a_; i < chrs_.size(); i++) {
    chrs_[i].printCharacter();
  }
}

void Battler::printTurnOrder() {
  for (int& order : turn_order_) {
    std::cout << order << ", ";
  }
}

#endif