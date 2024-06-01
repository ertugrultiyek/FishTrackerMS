import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.signal import detrend, resample
from sippy import SystemIdentification as SysID

def load_data(experiments):
    trials = []
    cage = None
    for experiment in experiments:
        table = pd.read_excel(experiment)
        fish_data = detrend(table['Fish'])
        if cage is None:
            cage = detrend(table['Cage'])
            t = np.arange(len(cage))
        else:
            fish_data = resample(fish_data, len(cage))
        trials.append(fish_data)
    return t, cage, trials

experiments = [
    'Data/samsun low light window 7cm/7cm/trial01_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_04_22_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial02_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_08_20_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial03_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_10_11_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial04_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_11_50_2022_TRACK.xlsx',
    'Data/samsun low light window 7cm/7cm/trial05_DR_sos_eigenmania_fish01_IL_WY_LS_CL_Fri_Sep_16_10_13_41_2022_TRACK.xlsx',
]

t, cage, trials = load_data(experiments)

# Repeat the input 'cage' for each trial
input_repeated = np.tile(cage, len(trials))
output = np.hstack(trials)

# Prepare data for system identification
data = np.vstack((input_repeated, output)).T

# Perform system identification using ARX model
system_id = SysID.arx(data, nu=1, ny=1)

# Retrieve the estimated parameters
A = system_id.A[1]  # This gives the estimated A coefficient of the first-order system
B = system_id.B[1]  # This gives the estimated B coefficient of the first-order system

print(f"Estimated parameters: A = {A}, B = {B}")

# Generate the estimated response
estimated_response = np.zeros_like(t)
for i in range(1, len(t)):
    estimated_response[i] = A * estimated_response[i-1] + B * cage[i]

plt.figure()
plt.plot(t, trials[0], 'o', label='Measured data')
plt.plot(t, estimated_response, '-', label='Estimated First Order System')
plt.xlabel('Time [s]')
plt.ylabel('Response')
plt.legend()
plt.show()
