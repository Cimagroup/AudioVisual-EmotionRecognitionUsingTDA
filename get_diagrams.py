
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

from scipy import signal
from persim import plot_diagrams, persistent_entropy
import gtda.homology as hl
import gtda.time_series as ts
import librosa as lr



def emotions_second(file1):
    #read the audio and create the time array (timeline)
    audio, sfreq = lr.load(file1)  #.load an audio file and decodes it into a 1-dimensional which is a time series AUDIO, and sfreq is a sampling

    dur_sec = time.shape[0]/sfreq

    tempo = lr.beat.tempo(audio, sfreq)

    yk = signal.resample(audio, 10000)
    noise = np.random.normal(0, 1, 10000)
    yk = yk + noise

    windowSize = 24

    yk = yk.reshape((2,500))


    return yk



def get_diag(embbeded, diagramas):
    homology_dimensions = (0, 1)
    VR = hl.VietorisRipsPersistence(homology_dimensions = [0,1], n_jobs=1)

    sliding_window = ts.SlidingWindow(embbeded.shape[1]-1, 4)
    embedded_window = sliding_window.fit_transform(embbeded.T)
    #sliding_window3 = ts.SlidingWindow(embbeded3.shape[1] - 1, 4)
    #embedded_window3 = sliding_window3.fit_transform(embbeded3.T)
    diagrams = VR.fit_transform(embedded_window)
    #diagrams3 = VR.fit_transform(embedded_window3)

    diagrams = diagrams[:, :, :-1]
    #diagrams3 = diagrams3[:, :, :-1]
    diagrams = [clean_ceros(item) for item in diagrams]

    #diagrams3 = [clean_ceros(item) for item in diagrams3]
    entropy = persistent_entropy.persistent_entropy(diagrams, keep_inf=False, val_inf=None, normalize=False)
    #z = np.zeros((len(diagrams[0]), 1), dtype=int)

    #diagrams[0] = np.append(diagrams[0], z, 1)
    #diagrams = [list(diagrams[0][item]) for item in range(len(diagrams[0]))]

    diagramas.append(diagrams)
    #entropy3 = persistent_entropy.persistent_entropy(diagrams3, keep_inf=False, val_inf=None, normalize=False)
    entropy = pd.DataFrame(entropy)
    #entropy3 = pd.DataFrame(entropy3)
    return entropy, diagramas

def clean_ceros(d):
    index = [item1 >= item2 for item1, item2 in zip(d[:, 0], d[:, 1])]
    result = [i for i, e in enumerate(index) if e == bool(True)]
    d = np.delete(d, result, axis=0)
    return d


