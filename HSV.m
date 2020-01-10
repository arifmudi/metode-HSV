clc; clear;

%%% proses merubah warna RGB (Red, Green dan Blue) menjadi HSV (Hue,
%%% Saturation, dan Value)

%%% created by: Arif Mudi Priyatno 
%%% https://github.com/arifmudi

%%% refensi : Color Gamut Transform Pairs
%%% (https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Color+Gamut+Transform+Pairs&btnG=)
%% membaca gambar
gambar = imread('depan/r1.png');
gambar = imresize(gambar,[400,400]);

% figure
% imshow(gambar)


%% memisahkan channel warna red, green dan blue
Red     = gambar(:,:,1);
Green   = gambar(:,:,2);
Blue    = gambar(:,:,3);

%% membuat Red green dan blue menjadi [0-1]

R = im2double(Red);
G = im2double(Green);
B = im2double(Blue);

%% mencari Nilai V (Value)
V = max(max(R,G),B);

%% mencari nilai S (Saturation)
X = min(min(R,G),B);

[m,n] = size(X);
S = [];
for is=1:m
    for js=1:n
        if V(is,js) == 0
            S(is,js) = 0;
        else
            S(is,js) = (V(is,js) - X(is,js)) / V(is,js);
        end
    end
end

%% mencari nilai H (Hue)

% cari r 
r = (V-R) ./ (V-X); r(isnan(r))=0;
% cari g
g = (V-G)./(V-X); g(isnan(g))=0;
% cari b
b = (V-B)./(V-X); b(isnan(b))=0;

H = [];
for ih=1:m
    for jh=1:n
        if R(ih,jh) == 0 && G(ih,jh) == 0 && B(ih,jh) == 0
                H(ih,jh) = 0;
        elseif R(ih,jh) == V(ih,jh)
            if G(ih,jh) == X(ih,jh)
                H(ih,jh) = 5 + b(ih,jh);
            else
                H(ih,jh) = 1 - g(ih,jh);
            end
        elseif G(ih,jh) == V(ih,jh)
            if B(ih,jh) == X(ih,jh)
                H(ih,jh) = 1 + r(ih,jh);
            else
                H(ih,jh) = 3 - b(ih,jh);
            end
        else
            if R(ih,jh) == X(ih,jh)
                H(ih,jh) = 3 + g(ih,jh);
            else
                H(ih,jh) = 5 - r(ih,jh);
            end
        end
    end
end
H = H/6;

HSVimage = cat(3,H,S,V);
% figure 
% imshow(HSVimage)