%% ecg data
clear;
close all;
clc;
load('Subject00_1_edfm.mat');
a=val;
T=1;
fs=1000;
N=length(a);
ts=1/fs;
t=(0:N-1)*ts;
%% dct of the signal
dct_Sig=dct(a);
%% sorting in descending order
[XX,ind] = sort(abs(dct_Sig),'descend');
%% 98 percent energy in the signal
need = 1;
while norm(dct_Sig(ind(1:need)))/norm(dct_Sig)<0.75
   need = need+1;
end
c_r=N/need;
disp('compression ratio=');
disp(c_r);
%xpc = need/length(dct_Sig)*100;
%% MAKE OTHER VALUES 0
dct_Sig(ind(need+1:end)) = 0;
xx = idct(dct_Sig);
%% Plots
subplot(3,1,1); 
plot(t,a);
title('Original signal');
subplot(3,1,2);
plot(t,xx);
title('Reconstructed');
subplot(3,1,3);
plot(t,a-xx);
title('Difference');
%subplot(4,1,4);
%plot([a;xx;a-xx]')
legend([int2str(c_r) '% compression ratio']);
%%Power
Eo=(norm(a));
disp('Energy of original signal=');
disp(Eo);
Er=(norm(xx));
disp('Energy of reconstructed signal=');
disp(Er);
%%Percentage
per=(Er/Eo)*100;
disp('Percentage of energy in reconstructed=');
disp(per);
%%Contents
save('new.mat','xx');
%save('new.mat','-v6');
%save('Subject00_1_edfm.mat','-v6');
%save('old.mat','a');
disp('comparison');
%whos('-file','new.mat');
z=dir('new.mat');
k=dir('Subject00_1_edfm.mat');
disp(k);
disp(z);
