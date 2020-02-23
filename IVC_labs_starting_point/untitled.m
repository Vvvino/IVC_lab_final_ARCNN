clear;
A = [1,2;
    3,4];
B = padarray(A,[4,4],0,'pre');
C = padarray(B,[8,8],0,'post');