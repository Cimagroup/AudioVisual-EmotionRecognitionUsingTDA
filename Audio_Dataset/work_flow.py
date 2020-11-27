import matplotlib.pyplot as plt
from test import emotions
from get_diagrams import get_diag
import pandas as pd
import itertools
from plotting import plot
from machine_learning import machine_learning

def work_flow():

    # load data that will be used in the script
    dir_name = 'Audio_Speech_Actors_01-24-2/'
    base_filename = 'Actor_'
    names = 'Actor'

    # define the address of the dataset
    file = [dir_name + base_filename + str(i) + '/' + names + str(i) + '_' + str(j) + '.wav'
                    for i, j in itertools.product(range(1, 25), range(1, 61))]

    #initializate the dataframe to fill
    d = pd.DataFrame({'Entropy': [], 'Duracion': [], 'Tempo': []})
    diagramas = []
    for item in file:
        #using function emotions to get the embedder and duration in seconds of audio
        try:
            embedder, dur_sec, tempo = emotions(item)
            #get diagrams
            entropy, diagramas = get_diag(embedder, diagramas)

            d = d.append({'Entropy': float(entropy[0]),  'Duracion': dur_sec, 'Tempo': tempo}, ignore_index=True)
            print(item)
        except:
            pass

    #plot(embedder)
    machine_learning(d, diagramas)

    return

if __name__ == "__main__":
    work_flow()
