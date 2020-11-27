import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import gudhi
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

def machine_learning(d, diagramas):
    dataset = pd.read_csv('clases.csv', delimiter=';', encoding='latin-1', keep_default_na=False)
    y = dataset.iloc[:, 1].values #to get the category emotion



    # TO create training and test splits , execute the following scritp
    X_train, X_test, y_train, y_test = train_test_split(d, y, test_size=0.20)


    # the above script splits the dataset into 80% and 20% test data,
    # Feature scaling
    # before making any actual predictions, it is always a good practice to scale the features so that all of them can be uniformly
    # evaluated.
    # we are going to use the gradient descent algorithm


    scaler = StandardScaler()
    scaler.fit(X_train)

    X_train = scaler.transform(X_train)
    X_test = scaler.transform(X_test)


    classifier = KNeighborsClassifier(n_neighbors=40)
    classifier.fit(X_train, y_train)

    # the first step is to import the KNeighborsClassifier from library, in the second line this classifier is initialized with
    # one parameter. THis is basically the value for the K. There is no ideal value for K and it is selected after testing and evaluation

    # Final step is to make predictions on our test data. to do so, execute the following script

    y_pred = classifier.predict(X_test)

    # For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used


    print(confusion_matrix(y_test, y_pred))
    print(classification_report(y_test, y_pred))

    # A way to help you find the bes value of K is to plot the graph of K value and the corresponding error rate for dataset
    # lets first calculate the mean of error for all the predicted values where K ranges from 1 to 40
    error = []

    for i in range(1, 40):
        knn = KNeighborsClassifier(n_neighbors=i)
        knn.fit(X_train, y_train)
        pred_i = knn.predict(X_test)
        error.append(np.mean(pred_i != y_test))

    plt.figure(figsize=(12, 6))
    plt.plot(range(1, 40), error, color='red', linestyle='dashed', marker='o',
             markerfacecolor='blue', markersize=10)
    plt.title('Error Rate K Value')
    plt.xlabel('K Value')
    plt.ylabel('Mean Error')

    # from the output we can see that the mean error is zeros, the advise is to play with the values of K to see how it impacts the accuracy
    # of predictions.
    return



def machine_learning_second(diagramas):
    dataset = pd.read_csv('prueba5.csv', delimiter=';', encoding='latin-1', keep_default_na=False)
    y = dataset.iloc[:, 1].values
    X_train, X_test, y_train, y_test = train_test_split(diagramas, y, test_size=0.20)
    # the above script splits the dataset into 80% and 20% test data,

    N = len(X_train)
    D = np.zeros((N, N))
    M = len(X_test)
    D1 = np.zeros((M, M))

    #Built distance matrix of persistence diagrams (Bottleneck distance)
    for i in range(N):
        for j in range(i + 1, N):
            D[i, j] = my_dist(X_train[i], X_train[j])
            D[j, i] = D[i, j]

    for i in range(M):
        for j in range(i + 1, M):
            D1[i, j] = my_dist(X_test[i], X_test[j])
            D1[j, i] = D1[i, j]

    return

    # Create the fake data matrix: just the indices of the timeseries

    X = np.arange(N).reshape((N, 1))
    classifier = KNeighborsClassifier(n_neighbors=40)
    classifier.fit(D, y_train)

    # the first step is to import the KNeighborsClassifier from library, in the second line this classifier is initialized with
    # one parameter. THis is basically the value for the K. There is no ideal value for K and it is selected after testing and evaluation

    # Final step is to make predictions on our test data. to do so, execute the following script

    y_pred = classifier.predict(D1)

    # For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used

    print(confusion_matrix(y_test, y_pred))
    print(classification_report(y_test, y_pred))

    # A way to help you find the best value of K is to plot the graph of K value and the corresponding error rate for dataset
    # lets first calculate the mean of error for all the predicted values where K ranges from 1 to 40
    error = []

    for i in range(1, 40):
        knn = KNeighborsClassifier(n_neighbors=i)
        knn.fit(D, y_train)
        pred_i = knn.predict(D1)
        error.append(np.mean(pred_i != y_test))

    plt.figure(figsize=(12, 6))
    plt.plot(range(1, 40), error, color='red', linestyle='dashed', marker='o',
             markerfacecolor='blue', markersize=10)
    plt.title('Error Rate K Value')
    plt.xlabel('K Value')
    plt.ylabel('Mean Error')

    #then latter we can select the optimal k.
    # from the output we can see that the mean error is zeros, the advise is to play with the values of K to see how it impacts the accuracy
    # of predictions.

    #Testing different classifier

    knn.fit(D, y_train)
    gnb = GaussianNB().fit(D, y_train)
    dtree_model = DecisionTreeClassifier(max_depth=2).fit(D, y_train)
    svm_model_linear = SVC(kernel='linear', C=1).fit(D, y_train)
    y_pred = knn.predict(D)
    gnb_predictions = gnb.predict(D)
    accuracy0 = knn.score(D, y_train)
    accuracy1 = gnb.score(D, y_train)
    accuracy2 = dtree_model.score(D, y_train)
    accuracy3 = svm_model_linear.score(D, y_train)
    print(knn.kneighbors(D[0]))
    print(knn.predict(D))

    # For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used
    print(confusion_matrix(X_train, y_pred))
    print(classification_report(y_test, y_pred))


def my_dist(x ,y):
    #bottleneck distance between diagrams
    x=[list(x[0][item]) for item in range(len(x))]
    y=[list(y[0][item]) for item in range(len(y))]
    d= gudhi.bottleneck_distance(x,y)
    message = "Bottleneck distance value = " + '%.8f' % gudhi.bottleneck_distance(x,y)

    return d
