experiments = {
    'samsun low light window 7cm\7cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_08_20_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial03_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_10_11_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_11_50_2022_TRACK.xlsx',
    'samsun low light window 7cm\7cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_13_41_2022_TRACK.xlsx',

    'samsun low light window 21cm\21cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_46_43_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_48_50_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial03_DL_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_50_57_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_54_12_2022_TRACK.xlsx',
    'samsun low light window 21cm\21cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LL_CL_Thu_Sep_15_09_56_25_2022_TRACK.xlsx',
    
    'samsun low light window 14cm\14cm\trial01_DR_sos_eigenmania_fish01_IL_WY_LM_CL_Thu_Sep_15_13_54_05_2022_TRACK.xlsx',
    'samsun low light window 14cm\14cm\trial02_DR_sos_eigenmania_fish01_IL_WY_LM_CL_Thu_Sep_15_13_56_51_2022_TRACK.xlsx',
    'samsun low light window 14cm\14cm\trial03_DR_sos_eigenmania_fish01_IL_WY_LM_CL_Thu_Sep_15_14_00_01_2022_TRACK.xlsx',
    'samsun low light window 14cm\14cm\trial04_DR_sos_eigenmania_fish01_IL_WY_LM_CL_Thu_Sep_15_14_02_22_2022_TRACK.xlsx',
    'samsun low light window 14cm\14cm\trial05_DR_sos_eigenmania_fish01_IL_WY_LM_CL_Thu_Sep_15_14_04_12_2022_TRACK.xlsx',

    'samsun low light nowindow 21cm\21cm\trial01_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_03_18_2022_TRACK.xlsx',
    'samsun low light nowindow 21cm\21cm\trial02_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_05_25_2022_TRACK.xlsx',
    'samsun low light nowindow 21cm\21cm\trial03_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_07_26_2022_TRACK.xlsx',
    'samsun low light nowindow 21cm\21cm\trial04_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_09_31_2022_TRACK.xlsx',
    'samsun low light nowindow 21cm\21cm\trial05_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_11_33_2022_TRACK.xlsx',
     };

readtable("samsun low light nowindow 21cm\21cm\trial02_DL_sos_eigenmania_fish01_IL_WN_LL_CL_Thu_Sep_15_12_05_25_2022_TRACK.xlsx")

fishes = [];

for experimentIdx = 1:length(experiments)
    experiment = experiments{experimentIdx};
    table = readtable(experiment);
    fish = table.Fish;
    fish = fish(1:end-0);
    fishes = [fishes detrend(fish)];
end

table_0 = readtable(experiments{1});
cage = table_0.Cage;
cage = cage(1:end-0);
cage = detrend(cage);

Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = Fs/L*(0:L-1);

figure,
hold on; box on;
plot(t, cage, '.r', 'LineWidth', 4);

for fish = fishes
    Fs = 25;
    t = 0:1/Fs:(length(fish)-1)/Fs;

    plot(t, fish, 'LineWidth', 2);
end

legend()

%%
hold on; box on;

Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = Fs/L*(0:L-1);

for fish = fishes
    H = fft(fish) ./ fft(cage);

    plot(f, log(abs(H)), 'LineWidth', 1);
end


xlabel("f (Hz)")
ylabel("|fft|")
legend()

%% Bode Plot
hold on; box on;

Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage) - 200;             % Length of signal
t = (0:L-1)*T;        % Time vector
f = Fs/L*(0:L-1);

H_tf_s = [];

for fish = fishes
    H = fft(fish(101:end-100)) ./ fft(cage(101:end-100));

    H_tf = frd(H, f*2*pi);

    H_tf_s = [H_tf_s H_tf];

    bodeplot(H_tf);
end

legend()

%% Bode Plot
% hold on; box on;
% 
% Fs = 25;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% L = length(cage) - 200;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% f = Fs/L*(0:L-1);
% 
% H_tf_s = [];
% 
% for fish = fishes
%     % Define the data object for system identification
%     %data = iddata(fish(51:450), cage(51:450));
% 
%     % Estimate the transfer function model
%     % Set the order of the transfer function [number of zeros, number of poles, delay]
%     order = [2 2 0.28]; % Example order, adjust based on your data and system
%     sys = tfest(data, order(1), order(2), order(3));
%     % bodeplot(sys);
% 
%     plotoptions = bodeoptions;
%     plotoptions.Grid = 'on';
%     plotoptions.FreqScale = 'log'; % 'linear' for linear scale (default mode is log btw)
%     plotoptions.FreqUnits = 'Hz';  % 'rad/s' for rad/s domain (default mode is rad/s btw)
%     bodeplot(sys,plotoptions); % We should choose proper range for seeing!
% 
%     H_tf_s = [H_tf_s sys];
%end

legend()

%%

Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = (-L/2:1:L/2-1)/Fs;

stem(f, abs(fftshift(fft(cage)))/L);
hold on;

%%

Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = transpose(-L/2:1:L/2-1)/Fs;

fish = fishes(:,1);

stem(f, abs(fftshift(fft(fish)))/L);

%%
Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = (-L/2:1:L/2-1)/Fs;

f_primes = [2 3 5 7 11 13 17 19 23 29 31 37 41] .* 3;
prime_indices = [L/2+1 - f_primes L/2+1 + f_primes];

C = abs(fftshift(fft(cage)))/L;
F = abs(fftshift(fft(fishes(:,3))))/L;

C_trimmed = zeros(L, 1);
F_trimmed = zeros(L, 1);

C_trimmed(prime_indices) = C(prime_indices);
F_trimmed(prime_indices) = F(prime_indices);

figure,
hold on;
stem(f, C_trimmed);
stem(f, F_trimmed);

%%
Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = (-L/2:1:L/2-1)/Fs;

f_primes = [2 3 5 7 11 13 17 19 23 29 31 37 41] .* 3;
prime_indices = [L/2+1 - f_primes L/2+1 + f_primes];

C = abs(fftshift(fft(cage)))/L;
C_trimmed = zeros(L, 1);
C_trimmed(prime_indices) = C(prime_indices);

figure,
hold on;
stem(f, log(C_trimmed), 'LineWidth', 3);

for fish = fishes
    F = abs(fftshift(fft(fish)))/L;
    F_trimmed = zeros(L, 1);
    F_trimmed(prime_indices) = F(prime_indices);
    stem(f, log(F_trimmed), 'LineWidth', 2);
end

legend();

%%
Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = (-L/2:1:L/2-1)/Fs;

f_primes = [2 3 5 7 11 13 17 19 23 29 31 37 41] .* 3;
prime_indices = [L/2+1 - f_primes L/2+1 + f_primes];

C = fft(cage);
F = fft(fishes(:,1));

C_trimmed = zeros(L, 1);
F_trimmed = zeros(L, 1);

C_trimmed(prime_indices) = C(prime_indices);
F_trimmed(prime_indices) = F(prime_indices);

H = F_trimmed ./ C_trimmed;
H_tf = frd(H, f*2*pi);

figure,
hold on;
% stem(f, C_trimmed);
% stem(f, F_trimmed);
plot(f, abs(H), '.-');

%%
Fs = 25;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(cage);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = (-L/2:1:L/2-1)/Fs;

f_primes = [2 3 5 7 11 13 17 19 23 29 31 37 41] .* 3;
prime_indices = [L/2+1 - f_primes L/2+1 + f_primes];

C = fft(cage);
C_trimmed = zeros(L, 1);
C_trimmed(prime_indices) = C(prime_indices);

H_tf_s = [];

figure,
hold on, box on,

for fish = fishes
    F = fft(fish);
    F_trimmed = zeros(L, 1);
    F_trimmed(prime_indices) = F(prime_indices);

    H = F_trimmed ./ C_trimmed;

    H_tf = frd(H, f*2*pi);
    H_tf_s = [H_tf_s H_tf];

    bodeplot(H_tf, f_primes ./ Fs .* 2*pi);
end

legend()
grid on

