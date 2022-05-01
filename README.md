# TestYourLuck
This simple coin flip smart contract allows you to try your luck by betting your virtual money.

Harmony testnet address: 0x08a5ad96D9F9F7C032e0E54e3C521D42DEfdd277



### 1. It gives you the following seven buttons to play with -
  
  ![image](https://user-images.githubusercontent.com/58781850/166144887-f9189309-ebc8-495e-a4bc-b73b9dadd1be.png)
  
  ###### a. addPlayer - adds new player or resets existing one
  
  ###### b. drawBet   - make draw and set the varaiables according to result
  
  ###### c. placeBet  - place a bet
     
  ###### d. betAmt    - current bet amount (it's 0 if there is no bet placed)
  
  ###### e. betOn     - an enum instance; 0 for Head, 1 for Tail
  
  ###### f. rand_v    - random variable (the same value not be used to decide win, this will be regenerated during draw)
  
  ###### g. remAmount - the amount a player is left with


### 2. Here's  one example of a bet

![image](https://user-images.githubusercontent.com/58781850/166144980-6ecb2a28-97a9-4ae1-b143-f5996d6dc16e.png)
and this is the log

![image](https://user-images.githubusercontent.com/58781850/166145045-b3444b2e-b379-453e-955c-48491d2ccd4f.png)


This draw resulted in to win, and thus win event was triggered. The final amount is now 120 units, as it should be - 

![image](https://user-images.githubusercontent.com/58781850/166144009-bb03431a-cfca-46ed-9602-463975d29602.png)
