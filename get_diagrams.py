

import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

from scipy import signal
from persim import plot_diagrams, persistent_entropy
import gtda.homology as hl
import gtda.time_series as ts
import librosa as lr



def get_diag(embbeded, diagramas):
    homology_dimensions = (0, 1)
    #Vietoris Rips filter applied
    VR = hl.VietorisRipsPersistence(homology_dimensions = [0,1], n_jobs=1)

    sliding_window = ts.SlidingWindow(embbeded.shape[1]-1, 4)
    embedded_window = sliding_window.fit_transform(embbeded.T)

    diagrams = VR.fit_transform(embedded_window)

    diagrams = diagrams[:, :, :-1]
    #clean ceros elements
    diagrams = [clean_ceros(item) for item in diagrams]

    entropy = persistent_entropy.persistent_entropy(diagrams, keep_inf=False, val_inf=None, normalize=False)

    diagramas.append(diagrams)

    entropy = pd.DataFrame(entropy)

    return entropy, diagramas



def get_diag2(diagramas):
    homology_dimensions = (0, 1)
    #Vietoris Rips filter applied
    VR = hl.VietorisRipsPersistence(homology_dimensions = [0,1], n_jobs=1)

    diagrams = VR.fit_transform(diagramas)

    diagrams = diagrams[:, :, :-1]
    #clean ceros elements
    diagrams = [clean_ceros(item) for item in diagrams]

    diagramas.append(diagrams)


    return diagramas



def clean_ceros(d):
    index = [item1 >= item2 for item1, item2 in zip(d[:, 0], d[:, 1])]
    result = [i for i, e in enumerate(index) if e == bool(True)]
    d = np.delete(d, result, axis=0)
    return d