import matplotlib.pyplot as plt


def plot(embedder):

    fig, ax = plt.subplots(nrows=3, ncols=1, figsize=(15, 14))
    ax[1].plot(embedder[0, :], embedder[1, :])

    return