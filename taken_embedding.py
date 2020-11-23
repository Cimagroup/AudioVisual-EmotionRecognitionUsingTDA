import numpy as np # linear algebra

import matplotlib.pyplot as plt #plotting

import librosa as lr
from librosa import display

from parameters_estimators import get_parameters

def emotions(file1):
    #read the audio and create the time array (timeline)
    audio, sfreq = lr.load(file1)  #.load an audio file and decodes it into a 1-dimensional which is a time series AUDIO, and sfreq is a sampling
    #rate fo AUDIO , by default is sfreq = 22kHz.

    time = np.arange(0, len(audio))/sfreq
    #plot audio over time


    #determine the duration of the signal
    dur_sec = time.shape[0]/sfreq

    #calculate information extra related with the audio

    out = biosppy.signals.ecg.ecg(audio, sfreq,  show=True)
    fig, ax = plt.subplots()
    ax.plot(time, out[1])
    ax.set(xlabel='Time(s)', ylabel='Sound Amplitude')
    plt.show()

    #get melspectogram of the audio
    spec = lr.feature.melspectrogram(y= audio, sr=sfreq)


    # #Separate the initial audio series into harmonic and percussive components

    data_h, data_p = lr.effects.hpss(audio)
    spec_h = lr.feature.melspectrogram(data_h, sr = sfreq)
    spec_p = lr.feature.melspectrogram(data_p, sr= sfreq)

    chroma = lr.feature.chroma_cqt(y = data_h, sr = sfreq)
    plt.figure(figsize=(18,5))

    lr.display.specshow(chroma, sr =  sfreq, x_axis='time', y_axis='chroma', vmin= 0, vmax = 1)

    plt.figure(figsize=(20, 8))
    plt.title('Audio: Chroma Spectrogram')
    lr.display.specshow(chroma, sr=sfreq, x_axis='s', y_axis='chroma' )

    #how fast is the song, estima el tempo de la muetra del audioe n latidos por minuto

    tempo = lr.beat.tempo(audio, sfreq)
    #resample the signal
    from gtda.time_series import Resampler
    periodic_sampler = Resampler(period = 1000)
    y_k = periodic_sampler.fit_transform(audio)
    fig, ax = plt.subplots()
    ax.plot(time[0:len(y_k)], y_k)

    datDelayInformation =  get_parameters(Signal)
    # embedded in two dimensions
    embedder = takensEmbedding(y_k, datDelayInformation[0], datDelayInformation[1])

    return embedder, dur_sec, tempo


def takensEmbedding (data, delay, dimension):
    "This function returns the Takens embedding of data with delay into dimension, delay*dimension must be < len(data)"
    if delay*dimension > len(data):
        raise NameError('Delay times dimension exceed length of data!')
    embeddedData = np.array([data[0:len(data)-delay*dimension]])
    for i in range(1, dimension):
        embeddedData = np.append(embeddedData, [data[i*delay:len(data) - delay*(dimension - i)]], axis=0)
    return embeddedData
