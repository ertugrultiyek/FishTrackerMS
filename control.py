import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.signal import detrend
from scipy.optimize import minimize
import control as ctrl

# Define a function to create a first-order plus time delay (FOPTD) model
def foptd_model(K, T, L, t):
    s = ctrl.TransferFunction.s
    G = K * ctrl.pade(L, 1)[0] * ctrl.tf([1], [T, 1])  # Pade approximation for delay
    _, y_out = ctrl.step_response(G, t)
    return y_out

# Load and preprocess the data
experiments = [
    'Data/samsun low light window 7cm/7cm/trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial02_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_08_20_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial03_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_10_11_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial04_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_11_50_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial05_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_13_41_2022_TRACK.xlsx',
]

trials = []
cage = None

for experiment in experiments:
    table = pd.read_excel(experiment)
    trials.append(detrend(table['Fish']))
    if cage is None:
        cage = detrend(table['Cage'])

# Ensure the input and output lengths match
t = np.arange(len(cage))

# Combine trials data for fitting
output = np.hstack(trials)

# Define the time vector for the simulation
t_sim = np.linspace(0, len(t), len(t))

# Initial guess for K, T, and L
initial_guess = [1.0, 1.0, 1.0]

# Objective function to minimize
def objective(params, t, y_meas):
    K, T, L = params
    y_model = foptd_model(K, T, L, t)
    error = y_meas - y_model
    return np.sum(error**2)

# Perform the optimization using scipy's minimize function
result = minimize(objective, initial_guess, args=(t_sim, output), bounds=[(0, 10), (0, 10), (0, 10)])
K_est, T_est, L_est = result.x

print(f"Estimated parameters: K = {K_est}, T = {T_est}, L = {L_est}")

# Plot the results for one of the trials
y_fitted = foptd_model(K_est, T_est, L_est, t_sim)
plt.figure()
plt.plot(t, trials[0], 'o', label='Measured data')
plt.plot(t_sim, y_fitted, '-', label='Fitted model')
plt.xlabel('Time [s]')
plt.ylabel('Response')
plt.legend()
plt.show()
