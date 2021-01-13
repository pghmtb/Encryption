# Encryption
https://amrron.com/2015/06/01/one-time-pads-unbreakable-encryption-an-old-school-tool/

Example.  Use the Conversion table to get the plain code then subtract the OTP key:
If the top number is less than the OTP key number, you just add 10 to the top number

M  E E T I N G     A T    1   4      P  M     I N    N Y  (.)
79 2 2 6 3 4 74 99 1 6 90 111 444 90 80 79 99 3 4 99 4 88 91
Plaincode : KEYID 79226 34749 91690 11144 49080 79993 49948 89191
OTP Key(-): 68496 47757 10126 36660 25066 07418 79781 48209 28600
-----------------------------------------------------
Ciphertext: 68496 32579 24623 65030 96188 42672 00212 01749 61591

Numbers are written between 90, before and after and the individual numbers
are repeated 3 Times.

To decode you just add the Ciphertext to the OTP Key(+).  If the result is greater than 10, just subtract 10.

