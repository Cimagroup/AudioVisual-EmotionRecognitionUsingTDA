# Audio Visual Emotion Recognition using TDA

RAVDESS database with two datasets analyzed: Video and Audio dataset:

Audio-Dataset: https://www.kaggle.com/uwrfkaggler/ravdess-emotional-speech-audio

Video-Dataset: https://zenodo.org/record/1188976#.X7yio2hKjIU

Video Dataset:

delaunay_construction.m Construction of the Delaunay triangulation in every video associated with 24 persons, defines the pathdata where it is the dataset address, return the Delaunay_base, the struct that we will use.

complex_filtration.m After get the delaunay_construction, we apply complex_filtration(Delaunay). The input is the Delaunay triangulation, in this code we built the complexes using the triangulation, taking the edges which form the squares and used them to form the square in every frame. We are working with 9 frames

filtrations.m This function obtain 8 border simplicial complexes filtered, from 4 view directions, 2 by each direction.
complex_wtsquare.m In this function we are going to split the complexes which form every cell to see the features which born and died in the same square on the complex.
Border_split.m get the barcode associated with each filter complex, applying the Incremental_algorithm.py

WORKFLOW.py
Load each complex and its index and apply:

complex2matrix.py: converts the complex in matricial way.

Persistence_new: ATR model defined in C++ to calculate the barcode or persistence diagrams associated with each filtration of the complex

per_entropy.py: Computes the persistence entropy of a set of intervals.

create_matrix.m: Built the different matrix based on persistence value to classify.

experiment: the first experiment done based on the entropy values of video

experiment3: experiment done in each filtration

feature24_vector.m: experiment done considering a vector of 24 features for each person.

Audio Dataset:

work_flow.py focuses on the first experiment, load data that will be used in the script, and initialize the dataframe to fill.

test.py using function emotions to get the embedder and duration in seconds of each audio signal

get_diagramas used to apply Vietoris-Rips filter and get the persisten_entropy values.

machine_learning is used to define classification techniques in the set of entropy values.

Inside test:

get_parameters.py gets the optimal parameter for taken embedding, which contains datDelayInformation for mutual information, false_nearest_neighours for embedding dimension.
takensEmbedding This function returns the Takens embedding of data with a delay into a dimension

Work_flow2: # using function emotions_second to obtain the resampled signal, get_diag2 to calculates the Vietoris-Rips filter

machine_learning_second: To construct a distance matrix of persistence diagrams (Bottleneck distance)

my_dist: To get the distance bottleneck between diagrams.
