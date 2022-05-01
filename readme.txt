# TestYourLuck
A simple coin flip contract, which allows you to try your luck by betting your virtual money.

Harmoney testnet address 0x08a5ad96D9F9F7C032e0E54e3C521D42DEfdd277


1. It gives you following 8 butons to play with -
  
  ![image](https://user-images.githubusercontent.com/58781850/166143467-63a6488e-7f6c-4ff8-a325-6db6988a4a2b.png)
  a. addPlayer - adds new player or resests existing one\n
  b. drawBet   - view result of a bet
  c. placeBet  - place a bet
  d. set_rand  - set value of random variable (the random varialbe will be regenerated during draw, this button is 
		 just for playing around. You can hide it by making it internal)
  e. betAmt    - current bet ammount (its 0 if there is no bet placed)
  f. betOn     - an enum instance; 0 for Head, 1 for Tail
  g. rand_v    - random variable (this will be regenerated during draw)
  h. remAmount - amount a player is left with

