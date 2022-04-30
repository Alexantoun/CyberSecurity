import luhn
# Card Number: 543210******1234 <-- This is given by Problem
#16 digit credit card number

for i in range (5432100000001234, 5432109999991234, 10000): #Increment by 10,000 upto 5432109....34
    if i%123457 == 0 and luhn.verify(str(i)):
        print(f'Value is: {i}')