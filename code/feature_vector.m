function [ v ] = feature_vector( I,segments )
A=unique(segments);
[c,~]=size(A);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow_lab = applycform(I, srgb2lab); % convert to L*a*b*
L = shadow_lab(:,:,1);
shadow_histeq = shadow_lab;
shadow_histeq(:,:,1) = histeq(L)*0.6;
shadow_histeq = applycform(shadow_histeq, lab2srgb);
% figure,imshow(shadow_histeq);

r=shadow_histeq(:,:,1);
g=shadow_histeq(:,:,2);
b=shadow_histeq(:,:,3);

v=zeros(c,9);
for i=1:c
    M=segments==A(i);
    v(i,1)=mean(im2double(R(M)));
    v(i,2)=mean(im2double(G(M)));
    v(i,3)=mean(im2double(B(M)));
    v(i,4)=std(im2double(R(M)));
    v(i,5)=std(im2double(G(M)));
    v(i,6)=std(im2double(B(M)));
    v(i,7)=mean(im2double(r(M)));
    v(i,8)=mean(im2double(g(M)));
    v(i,9)=mean(im2double(b(M)));
end
end

