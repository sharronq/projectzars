
        /*---------------------------Phase 1-----------------------------* /
 
/*---------------------------Attribute for a character-----------------------------*/



// A whole new class for animation action database
class CharacterAction    //  *P --> Static for all characters
class EnemyAction        //  *P --> Static for all bosses


//Structures for safety concerns
struct Name{};
struct Profile{};
struct HP{};
struct ATK{};
struct SPD{};



/*-------------------------Basic Info's of Character / NPC / Enemy-------------------------------*/
class Character{
    /*------------Variables--------------*/
    
    Name, Profile // *P --> Name and profile should be const
                  // *P --> Profile should contain an address to an image
    Attribute: HP ATK, SPD
    
    
    

     /*------------Rule 3,5,0--------------*/
    BuildCharacter() // Trigger system to build a character
    Character(Name, Profile, HP, ATK, SPD) //Constructor
    ~Character() //Destructor. I don't think it needs to be created, unless one of the above variable is dynamic
    
    //Copy constructor and copy assignment should be banned, Because each character is unique and should not be duplicated
    
    //Operators: undecide yet
     
    /*------------Functions--------------*/
    
    //display name and profile
    DisplayName();
    DisplayProfile();
    Display HP, ATK, SPD
    
};


      
      
      
      
      
      
      
      
      
      
      
      
      
      /*---------------------------Phase 2-----------------------------*/

/*-------------------------------------Fight-------------------------------------------------*/

// Trigger the fight
class OR namespace Fight{
    ...
};

class Team{
    array of 4 characters //Dynamic
    Current num of characters
    Pointer to current control character
    
};

class CharacterFight{
    ...
    
    
    //All below belong to fight scene
    // The reason is that during fight scene, the HP of a member should decrease, however it shouldn't affect the HP value in main page. So I think We should dynamic allocate selected characters for the fight.
    Attack()
    Defend()
    BeingAttacked()
}


class Enemy{
    ...
};

class EnemyFight{
    ...
}



/*-------------------------------------Main Page-------------------------------------------------*/
//Collection of characters, lock and unclock things....
class WareHouse{
    ...
};

//User bag page
class UserBag{
    ...
};
