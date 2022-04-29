# Card Number: 543210******1234 <-- This is given by Problem
#16 digit credit card number
def insertValue(cc:list, value:int):    #Handles placing guesses into the list of numbers
    numDigits = 6 - len(str(value))
    x = 0
    while x < numDigits:
        cc[6+x] = 0
        x += 1
    numIndex = 0
    while x < 6:
        cc[6+x] = str(value)[numIndex]
        numIndex+=1
        x+=1
    print(cc)
    
                        #  6   7   8   9  10  11 
creditCard = [5,4,3,2,1,0,'*','*','*','*','*','*',1,2,3,4]
luhnNumber = [2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1]

for x in range(0,16):   #Create a pattern of 2, 1, 2, 1...
    if x%2 == 0:
        luhnNumber.append(2)
    else:
        luhnNumber.append(1)

#First step is to find numbers that make credit-card number multiples of 123457
#Like in crypt arithmetic, loop through range of 0 - 999,999 then insert those numbers into the list and check
#Maybe it would be best to store valid credit card numbers into a list.
for i in range (0, 1_000_000):
    if i%999999==0:
        insertValue(creditCard, i)
    
print("Credit Card value is: ", end='')
print(creditCard)