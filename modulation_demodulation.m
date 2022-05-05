fs = 1000;             % ornekleme frekansi
t = -0.5 : 1/fs : 0.5; % zaman araligi

%********************************* mesaj isareti **************************
% 1 periyodda cizdirmek icin
% fs = 100000;         % ornekleme frekansi
% t = 0 : 1/fs : 0.04; % 1 periyodu icin zaman araligi

m = 10*cos(50*pi*t) + 20*cos(100*pi*t); % m(t)
% plot(m);

M = fftshift(fft(m))/length(m); % 0 frekansli bileseni merkezde gostermek icin

f_m = (fs/length(m))*(-length(m)/2 : (length(m)-1)/2); % 0 merkezli frekans araligi icin

c = 100*cos(500*pi*t); % c(t)

%**************************** module edilmis isaret ***********************
y = m .* c; % y(t)

Y = fftshift(fft(y))/length(y); % Y(f)

f_y = (fs/length(y))*(-length(y)/2 : (length(y)-1)/2);

%*********************************** e(t) *********************************
c_d = cos(100*pi*t); % demodulator tasiyici sinyali
e = y .* c_d; % e(t)

E = fftshift(fft(e))/length(e); % E(f)

f_e = (fs/length(e))*(-length(e)/2 : (length(e)-1)/2);

%*********************************** h(t) *********************************
h = 100*sinc(100*t); % analitik olarak hesaplanarak bulundu

H = fftshift(fft(h))/length(e); % = rect(f/100)
% plot(f_e, abs(H)); % dogru sonuc elde ediliyor mu kontrol edildi

%*********************************** z(t) *********************************
Z = H .* E; % Z(f) = H(f).E(f)

z = ifftshift(ifft(Z)); % Z(f)'in ters fourierinden z(t) elde edildi
f_z = (fs/length(z))*(-length(z)/2 : (length(z)-1)/2);

%********************************* plot ***********************************
figure(1);

% m(t)
subplot(4,2,1);
plot(t, m);
xlabel('t');
ylabel('A');
title('m(t)');

% M(f)
subplot(4,2,2);
plot(f_m, abs(M));
xlabel('f');
ylabel('A');
title('M(f)');

% y(t)
subplot(4,2,3);
plot(t, y);
xlabel('t');
ylabel('A');
title('y(t)');

% Y(f)
subplot(4,2,4);
plot(f_y, abs(Y));
xlabel('f');
ylabel('A');
title('Y(f)');

% e(t)
subplot(4,2,5);
plot(t, e);
xlabel('t');
ylabel('A');
title('e(t)');

% E(f)
subplot(4,2,6);
plot(f_e, abs(E));
xlabel('f');
ylabel('A');
title('E(f)');

% z(t)
subplot(4,2,7);
plot(t, z);
ylim([-1, 1]); % z(t) neredeyse 0'a yakin cikiyor, gosterebilmek icin y ekseni sinirlandirildi
xlabel('t');
ylabel('A');
title('z(t)');

% Z(f)
subplot(4,2,8);
plot(f_z, abs(Z));
ylim([-400, 400]); % Z(f) neredeyse 0'a yakin cikiyor, gosterebilmek icin y ekseni sinirlandirildi
xlabel('f');
ylabel('A');
title('Z(f)');