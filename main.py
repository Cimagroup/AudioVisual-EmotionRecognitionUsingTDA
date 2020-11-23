
import matplotlib.pyplot as plt
from test import temperature_base, emotions, get_diag
import pandas as pd
import itertools
from get_diagrams import emotion emotions_second
from machine_learning import machine_learning
def main():
    dir_name = 'Audio_Speech_Actors_01-24-2/'
    base_filename = 'Actor_'
    names = 'Actor'
    # define the address of the dataset
    file_diagram = [dir_name + base_filename + str(i) + '/' + names + str(i) + '_' + str(j) + '.wav'
                    for i, j in itertools.product(range(1, 25), range(5, 61))]


    d = pd.DataFrame({'Entropy': [], 'Duracion': [], 'Tempo': []})
    diagramas  = []
    for item in file_diagram:
        #using function emotions to get the embedder and duration in seconds of audio
        embedder, dur_sec, tempo, yk = emotions(item)
        signal =  emotion_second(item)
        entropy, diagramas = get_diag(yk, diagramas)

        d = d.append({'Entropy': float(entropy[0]),  'Duracion': dur_sec, 'Tempo': tempo}, ignore_index=True)
        print(item)

    machine_learning(d, diagramas)

    fig, ax = plt.subplots(nrows=3, ncols=1, figsize=(15, 14))
    # plotear la serie de tiempo y la embedida
    ax[0].plot(Signal)
    ax[1].plot(embedder[0, :], embedder[1, :])
    ax[2].plot(Signal)
    # plot the 3D embedding
    ax = fig.add_subplot(3, 1, 3, projection='3d')
    ax.plot(embedder3[0, :], embedder3[1, :], embedder3[2, :])

    return














if __name__ == "__main__":
    main()