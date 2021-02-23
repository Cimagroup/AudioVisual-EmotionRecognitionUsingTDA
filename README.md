# Audio Visual Emotion Recognition using TDA

RAVDESS database with two datasets analyzed: Video and Audio dataset:

Audio-Dataset: https://www.kaggle.com/uwrfkaggler/ravdess-emotional-speech-audio

Video-Dataset: https://zenodo.org/record/1188976#.X7yio2hKjIU

The Final Master project PDF document is available [here](https://github.com/Cimagroup/AudioVisual-EmotionRecognitionUsingTDA/blob/master/Thesis_doc.pdf).

## **Folder Video_Dataset:**

Dataset used is available in this url https://zenodo.org/record/1188976#.X7yio2hKjIU
The algorithm works in this order:

1. **delaunay_construction.m**: The first step of the algorithm in order to build the Delaunay triangulation in every video associated from dataset, remind that we have videos of 24 people and for each person 60 videos associated to 8 emotions. The first step is to defines the pathdata where it is the dataset address, that it is in format csv with the landmark point of the face. The coordinate of point X is is between position 2:297 and Y from 138:416 return the Delaunay_base, the struct that we will use in the code.

2. **complex_filtration.m**:  After get the delaunay_construction, we apply complex_filtration(Delaunay). The input is the Delaunay triangulation, in this code we built the complexes using the triangulation, taking the edges which form the squares and used them to form the square in every frame. We are working with 9 frames and this function calls the filtration function. Then, this function the return the complex asociated to each video, and the index position where each 3-cell is formed in the complex 

2.1. **filtrations.m** This function obtains 8 border simplicial complexes filtered, from 4 view directions, 2 by each direction.We applied a set of function in order to get the different complex, as you can see the funcion return Complex X in the direction of axis X, Complex X in direction of Y, Complex XY, Complex YX in diagonal direction and the same complex with the order inverted. 

2.2. **complex_wtsquare.m** In this function we are going to split the complexes which form every cell to see the features which born and died in the same square on the complex. 


3. **WORKFLOW.m**  One time that we have the complexes build, we are going to apply the Incremental Algorithm (Persistence_new) used in this thesis, the Incremental algorithm was implemented in C++ using differente topology libraries which offer this language. Then we get the barcode or persistence diagram associated to each filter complex obtained at begining. In this function we apply also the function (per_entropy) to summarise the information from the persistence diagram

Load each complex and its index and apply:

 3.1 **complex2matrix.py**: converts the complex obtained for the ATR model applied in matricial way as we explained on the thesis(page 50). 

 3.2 **Persistence_new**: ATR model defined in C++ to calculate the persisten homology and get the barcode or persistence diagrams     associated with each filtration of the complex. The psuedo-code of the algorithm you will find on the thesis.  

 3.3 **create_matrix.m**: Built the different matrix based on persistence value to classify. 

4. **experiment**: the first experiment done based on the entropy values of video, but it sets each filtration compex that we get, then for that we worked with vector of eight elements associated to each filtration. Later this matrix is splitted in training and test set in order to use APP Classificator from Matlab and gets the accuracy. 

5. **experiment3**: Experiment that construct the matrix with the information of each persisten value associate with one filtration of the complex calculated. Later this matrix is splitted in training and test set in order to use APP Classificator from Matlab and gets the accuracy. 

6. **feature24_vector.m**: experiment done considering a vector of 24 features for each person. in this experiment we dont get good results.

## **Folder Audio Dataset**:

In this url yo can finde the Audio-Dataset used for this implementation, the formal of the files are in .wav: https://www.kaggle.com/uwrfkaggler/ravdess-emotional-speech-audio

**Experiment 1**
1. **work_flow.py** focuses on the first experiment, load data that will be used in the script, and initialize the dataframe to fill.

1.1 **test.py** using function emotions to get the embedder and duration in seconds of each audio signal. Read the audio and create the time array (timeline), resample the signal, get the optimal parameter delay, apply the emmbedding algorithm

1.2 **get_parameters.py** function to get the optimal parameter for taken embedding, which contains datDelayInformation for mutual information, false_nearest_neighours for embedding dimension.

1.3 **TakensEmbedding**: This function returns the Takens embedding of data with a delay into a dimension

1.4 **per_entropy.py**: Computes the persistence entropy of a set of intervals according to the diagrama obtained.

1.5 **get_diagramas.py** used to apply Vietoris-Rips filter and get the persisten_entropy values.

2. **machine_learning.py** is used to define classification techniques in the set of entropy values. Create training and test splits. Import the KNeighborsClassifier from library. The parameter K is to plot in graph with corresponding error rate for dataset and calculate the mean of error for all the predicted values where K ranges from 1 to 40.

**Experment 2**

3. **Work_flow2.py**: Second experiment,  using function **emotions_second** to obtain the resampled signal, **get_diag2** from **test.py** to calculates the Vietoris-Rips filter.

4. **machine_learning_second**: To construct a distance matrix of persistence diagrams (Bottleneck distance). Upload the csv prueba5.csv that contains the label of the emotion associated to each rows of the matrix. Create the fake data matrix: just the indices of the timeseries. Import the KNeighborsClassifier from library. For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used. Testing different classifier to see what is the best one. GaussianNB;  DecisionTreeClassifier, knn and SVC. 

4.1 **my_dist**: To get the distance bottleneck between diagrams, function that we use to built the matrix of distance, that will be the input of the KNN algorithm.
