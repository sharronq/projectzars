#include <iostream>
#include "Character.h"
#include <vector>
#include "Battler.h"

int main() {

  // std::cout << "test" << std::endl;

  Character enemy_0("Enemy 0", 10, 100, 20);
  Character enemy_1("Enemy 1", 18, 50, 27);
  Character enemy_2("Enemy 2", 15, 60, 30);
  Character enemy_3("Enemy 3", 7, 120, 18);

  Character player_0("Player 0", 10, 100, 19);
  Character player_1("Player 1", 14, 80, 24);
  Character player_2("Player 2", 15, 60, 32);
  Character player_3("Player 3", 8, 100, 22);

  std::vector<Character> enemy_team = {enemy_0, enemy_1, enemy_2, enemy_3};
  std::vector<Character> player_team = {player_0, player_1, player_2, player_3};

  Battler test(enemy_team, player_team);
  test.printBattle();
  test.findTurnOrder();
  test.printTurnOrder();

  return 0;
}