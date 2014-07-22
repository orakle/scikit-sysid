import numpy as np
import matplotlib.pyplot as plt



class LFSR(object):
    def __init__(self, n, seed):
        self.tapsDict = {2 : (1,2),3: (1,3),4: (1,4), 5: (2,5),6: (1,6),
            7: (3,7), 8: (2,3,4,8),9: (4,9),10: (3,10),11: (2,11),12: (1,4,6,12),
            13: (1,3,4,13),14: (1,6,10,14),15: (1,15),16: (1,3,12,16),17: (3,17),
            18: (7,18),19: (1,2,5,19),20: (3,20),21: (2,21),22: (1,22),23: (5,23),
            24: (1,2,7,24),25: (3,25),26: (1,2,6,26),27: (1,2,5,27),28: (3,28),
            29: (2,29),30: (1,2,23,30),31: (3,31),32: (1,2,22,32),33: (13,33),
            34: (1,2,27,34)}
        self.n = n

        self.taps = self.tapsDict[self.n]
        self.shift_register = self.get_bits(seed, n)

    def shift(self):
        new_bit = sum([self.shift_register[tap - 1] for tap in self.taps]) % 2
        self.shift_register = self.shift_register[:-1]
        self.shift_register.insert(0, new_bit)
        return new_bit

    def get_bits(self, k, bits_to_get):
        # returns the first bits_to_get bits of k starting with the lowest
        bits = []
        for i in xrange(bits_to_get):
            bits.append(k % 2)
            k = k >> 1
        return bits



def prbs(sequence_length, input_channels = 1):
    # The period T of the sequence is based on the number of bits n in the sequence-generating polynomial where T = 2^n - 1.
    # In order to guarantee that the sequence doesn't repeat, we set the number of bits in the polynomial to produce a period
    # larger than the sequence length requested.
    n = np.log(sequence_length + 1)/np.log(2)
    n = int(np.ceil(n))

    u = np.zeros((input_channels, sequence_length))

    for c in range(input_channels):
        seed = int(np.random.rand() * 10000000000000)
        lfsr = LFSR(n, seed)
        u_c = np.fromiter([lfsr.shift() for i in range(sequence_length)], int, sequence_length)
        u[c,:] = u_c

    return u.transpose()


x = [x for x in range(1,26)]
u = prbs(25)
print u

#plt.ylim([-0.1,1.1])
#plt.step(x, u)
#plt.show()
