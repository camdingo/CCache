// heavy.hpp — intentionally large header to increase compile time
#pragma once

// Define many inline helper functions at global scope to increase compile time
#define HFN(N) inline int hf##N() { return N; }

HFN(1) HFN(2) HFN(3) HFN(4) HFN(5) HFN(6) HFN(7) HFN(8) HFN(9) HFN(10)
HFN(11) HFN(12) HFN(13) HFN(14) HFN(15) HFN(16) HFN(17) HFN(18) HFN(19) HFN(20)
HFN(21) HFN(22) HFN(23) HFN(24) HFN(25) HFN(26) HFN(27) HFN(28) HFN(29) HFN(30)
HFN(31) HFN(32) HFN(33) HFN(34) HFN(35) HFN(36) HFN(37) HFN(38) HFN(39) HFN(40)
HFN(41) HFN(42) HFN(43) HFN(44) HFN(45) HFN(46) HFN(47) HFN(48) HFN(49) HFN(50)
HFN(51) HFN(52) HFN(53) HFN(54) HFN(55) HFN(56) HFN(57) HFN(58) HFN(59) HFN(60)
HFN(61) HFN(62) HFN(63) HFN(64) HFN(65) HFN(66) HFN(67) HFN(68) HFN(69) HFN(70)
HFN(71) HFN(72) HFN(73) HFN(74) HFN(75) HFN(76) HFN(77) HFN(78) HFN(79) HFN(80)
HFN(81) HFN(82) HFN(83) HFN(84) HFN(85) HFN(86) HFN(87) HFN(88) HFN(89) HFN(90)
HFN(91) HFN(92) HFN(93) HFN(94) HFN(95) HFN(96) HFN(97) HFN(98) HFN(99) HFN(100)

#undef HFN

inline int heavy_value() {
    // Use several of the helper functions to avoid being optimized out entirely
    int sum = 0;
    for (int i = 1; i <= 100; ++i) {
        switch(i) {
#define CASE(N) case N: sum += hf##N(); break;
        CASE(1) CASE(2) CASE(3) CASE(4) CASE(5) CASE(6) CASE(7) CASE(8) CASE(9) CASE(10)
        CASE(11) CASE(12) CASE(13) CASE(14) CASE(15) CASE(16) CASE(17) CASE(18) CASE(19) CASE(20)
        CASE(21) CASE(22) CASE(23) CASE(24) CASE(25) CASE(26) CASE(27) CASE(28) CASE(29) CASE(30)
        CASE(31) CASE(32) CASE(33) CASE(34) CASE(35) CASE(36) CASE(37) CASE(38) CASE(39) CASE(40)
        CASE(41) CASE(42) CASE(43) CASE(44) CASE(45) CASE(46) CASE(47) CASE(48) CASE(49) CASE(50)
        CASE(51) CASE(52) CASE(53) CASE(54) CASE(55) CASE(56) CASE(57) CASE(58) CASE(59) CASE(60)
        CASE(61) CASE(62) CASE(63) CASE(64) CASE(65) CASE(66) CASE(67) CASE(68) CASE(69) CASE(70)
        CASE(71) CASE(72) CASE(73) CASE(74) CASE(75) CASE(76) CASE(77) CASE(78) CASE(79) CASE(80)
        CASE(81) CASE(82) CASE(83) CASE(84) CASE(85) CASE(86) CASE(87) CASE(88) CASE(89) CASE(90)
        CASE(91) CASE(92) CASE(93) CASE(94) CASE(95) CASE(96) CASE(97) CASE(98) CASE(99) CASE(100)
        default: break;
#undef CASE
        }
    }
    return sum;
}
