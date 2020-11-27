import numpy as np # linear algebra
from scipy import signal
from persim import plot_diagrams, persistent_entropy
import gtda.homology as hl
import gtda.time_series as ts
import matplotlib.pyplot as plt #p
import librosa as lr
from librosa import display
from get_parameters import get_parameters, takensEmbedding

def emotions(file1):
    #read the audio and create the time array (timeline)
    audio, sfreq = lr.load(file1)  #.load an audio file and decodes it into a 1-dimensional which is a time series AUDIO, and sfreq is a sampling
    #rate fo AUDIO , by default is sfreq = 22kHz.

    time = np.arange(0, len(audio))/sfreq
    #plot audio over time

    #determine the duration of the signal
    dur_sec = time.shape[0]/sfreq

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
    lr.display.specshow(chroma, sr=sfreq, y_axis='chroma' )
    #how fast is the song, estima el tempo de la muetra del audioe n latidos por minuto
    tempo = lr.beat.tempo(audio, sfreq)
    #resample the signal
    from gtda.time_series import Resampler
    periodic_sampler = Resampler(period = 10000)
    y_k = periodic_sampler.fit_transform(audio)
    fig, ax = plt.subplots()
    ax.plot(time[0:len(y_k)], y_k)

    #get the optimal parameter delay
    t, d= get_parameters(y_k)

    # embedded in two dimensions
    embedder = takensEmbedding(y_k, t, d)

    return embedder, dur_sec, tempo

def emotions_second(file1):
    #read the audio and create the time array (timeline)
    audio, sfreq = lr.load(file1)  #.load an audio file and decodes it into a 1-dimensional which is a time series AUDIO, and sfreq is a sampling

    yk = signal.resample(audio, 10000)
    noise = np.random.normal(0, 1, 10000)
    #add to the signal audio random noise
    yk = yk + noise

    windowSize = 24

    yk = yk.reshape((2,500))

    return yk
