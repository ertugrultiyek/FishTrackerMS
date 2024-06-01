%% Ahmet Abi
num = xlsread('2.xlsx');
x = '2.xlsx';
c1 = 'A69:A548';
c2 = 'B1:B481';
a1 = xlsread(x,c1);
b1 = xlsread(x,c2);
b2 = b1 - 70;
b = b2 / 500;
a = a1 / 450;
c = a1./b2; 
%t = 0:1:478;
Fs = 9600;                   % samples per second
dt = 1/Fs;                   % seconds per sample
StopTime = 0.0500;             % seconds
t = (0:dt:StopTime-dt)';     % seconds
f = 2*pi*1./t;
plot(f,c);

%% erzincan
% table = readtable("deneyler\erzincan\high\light\window\21cm\trial01_DR_sos_eigenmannia_fish05_IL_WY_LL_CH_Sat_Feb__4_13_42_51_2023_TRACK.xlsx");
table = readtable("samsun low light window 7cm\7cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx");

fish = table.Fish;
cage = table.Cage;

Fs = 25;

t = 0:1/Fs:(length(fish)-1)/Fs;

plot(t, fish, t, cage)

%% erzincan
table_0 = readtable("samsun low light window 7cm\7cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx");
table_1 = readtable("samsun low light window 7cm\7cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_08_20_2022_TRACK.xlsx");
table_2 = readtable("samsun low light window 7cm\7cm\trial03_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_10_11_2022_TRACK.xlsx");
table_3 = readtable("samsun low light window 7cm\7cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_11_50_2022_TRACK.xlsx");
table_4 = readtable("samsun low light window 7cm\7cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_13_41_2022_TRACK.xlsx");

fishes = [table_0.Fish, table_1.Fish, table_2.Fish, table_3.Fish, table_4.Fish];

cage = table_0.Cage;

hold on; box on;
plot(t, cage);

for fish = fishes
    Fs = 25;
    t = 0:1/Fs:(length(fish)-1)/Fs;

    plot(t, fish);
end

legend()

%% erzincan

experiments = {
    'samsun low light window 7cm\7cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_08_20_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial03_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_10_11_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_11_50_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_13_41_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_46_43_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_48_50_2022_TRACK.xlsx',
    % 'samsun low light window 21cm\21cm\trial03_DL_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_50_57_2022_TRACK.xlsx',
    % 'samsun low light window 21cm\21cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_54_12_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_56_25_2022_TRACK.xlsx',
    };

fishes = [];

for experimentIdx = 1:length(experiments)
    experiment = experiments{experimentIdx};
    table = readtable(experiment);
    fishes = [fishes detrend(table.Fish)];
end

table_0 = readtable(experiments{1});
cage = detrend(table_0.Cage);

hold on; box on;
plot(t, cage, '.r', 'LineWidth', 4);

for fish = fishes
    Fs = 25;
    t = 0:1/Fs:(length(fish)-1)/Fs;

    plot(t, fish, 'LineWidth', 2);
end

legend()

%%
fish_d = detrend(fish);
cage_d = detrend(cage);
plot(t, fish_d, t, cage_d)

%% Bodoslama sysid
% Define the data object for system identification
data = iddata(fish, cage);

% Estimate the transfer function model
% Set the order of the transfer function [number of zeros, number of poles, delay]
order = [2 2 0]; % Example order, adjust based on your data and system
sys = tfest(data, order(1), order(2), order(3));
bodeplot(sys)

%% Delay eklenmis sysid
% Define the data object for system identification
data = iddata(fish(51:450), cage(51:450));

% Estimate the transfer function model
% Set the order of the transfer function [number of zeros, number of poles, delay]
order = [2 2 0]; % Example order, adjust based on your data and system
sys = tfest(data, order(1), order(2), order(3));
bodeplot(sys)

%%
a = 1;
K = 1;

G = tf([K], [1 a]);

bodeplot(G)

%%
a = 1;
K = 1;
tau = 1;

G = tf([K], [1 a], 'InputDelay', tau);

bodeplot(G)

%%
a = 0;
K = 1;
tau = 1;

G = tf([K], [1 a], 'InputDelay', tau);

bodeplot(G)

%%
A = 5;
w0 = 100;
etha = 0.02;

G = tf([A*w0^2], [1 2*etha*w0 w0^2]);

bodeplot(G)
