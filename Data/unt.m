%num = xlsread('2.xlsx');
x = '1.xlsx';
t = 0:1:479;
c1 = 'A1:A481';
c2 = 'B1:B481';
a1 = xlsread(x,c1);
b1 = xlsread(x,c2);
b2 = b1 - 230;
b = b2 / 600;
a = a1 / 400;
c = a1./b2; 
plot(t,a,t,b);

%Fs = 9600;                   % samples per second
%dt = 1/Fs;                   % seconds per sample
%StopTime = 0.0500;             % seconds
%t = (0:dt:StopTime-dt)';     % seconds
%f = 2*pi*1./t;
%plot(f,c);

