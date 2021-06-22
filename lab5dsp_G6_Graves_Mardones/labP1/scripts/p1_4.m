%%%%% Lab 5 DSP
close all; clear; clc
%%% I.4

load vowels
P  = 15;


%MATLAB
a_vowel_a = lpc(vowel_a,P);

%LPC PROPIO
ra = xcorr(vowel_a);
ra_1p = ra(length(vowel_a)+1:length(vowel_a)+P);
ra_t  = ra(length(vowel_a):length(vowel_a)+P-1);

Ra = toeplitz(ra_t);

a_vowel_a_2 = -(Ra\ra_1p)';
a_vowel_a_2 = [1 a_vowel_a_2];

a = [a_vowel_a; a_vowel_a_2];


%plot(r_a)
%[valor, indice] = max(r_a);