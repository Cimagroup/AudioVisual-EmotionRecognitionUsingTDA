
import sys
import matplotlib.pyplot as plt

from test import temperature_base, emotions, get_diag
import numpy as np
import pandas as pd
import gudhi



def machine_learning(d, diagramas):
    dataset = pd.read_csv('prueba5.csv', delimiter=';', encoding='latin-1', keep_default_na=False)
    # y = dataset.iloc[:, 1].values

    test = sio.loadmat('matrix_total.mat')  # matrix of value

    X_m = test['matrix_total']
    y = X_m[:, 8]
    X_m = X_m[:, :8]

    from sklearn.model_selection import train_test_split

    X_train, X_test, y_train, y_test = train_test_split(diagramas, y, test_size=0.20)
    X_train_m, X_test_m, y_train_m, y_test_m = train_test_split(X_m, y, test_size=0.20)

    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.naive_bayes import GaussianNB
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.svm import SVC
    N = len(X_train)
    D = np.zeros((N, N))
    M = len(X_test)
    D1 = np.zeros((M, M))

    for i in range(N):
        for j in range(i + 1, N):
            D[i, j] = my_dist(X_train[i], X_train[j])
            D[j, i] = D[i, j]

    for i in range(M):
        for j in range(i + 1, M):
            D1[i, j] = my_dist(X_test[i], X_test[j])
            D1[j, i] = D1[i, j]


    message = "Bottleneck distance approximation = " + '%.8f' % gudhi.bottleneck_distance(a_Del, a_Del2, 0.1)
    message = "Bottleneck distance value = " + '%.8f' % gudhi.bottleneck_distance(a_Del,a_Del2)
    gudhi.plot_persistence_diagram(a_Del2)


    # Create the fake data matrix: just the indices of the timeseries

    X = np.arange(N).reshape((N, 1))
    knn = KNeighborsClassifier(n_neighbors=5)

    # knn = KNeighborsClassifier(weights='distance', algorithm='ball_tree', metric='pyfunc')

    knn.fit(D, y_train)
    gnb = GaussianNB().fit(D, y_train)
    dtree_model = DecisionTreeClassifier(max_depth=2).fit(D, y_train)
    svm_model_linear = SVC(kernel='linear', C=1).fit(D, y_train)
    y_pred = knn.predict(D)
    gnb_predictions = gnb.predict(D)
    accuracy0 = knn.score(D ,y_train)
    accuracy1 = gnb.score(D, y_train)
    accuracy2 = dtree_model.score(D, y_train)
    accuracy3 = svm_model_linear.score(D, y_train)

    from sklearn.metrics import classification_report, confusion_matrix

    print(confusion_matrix(y_train, y_pred))
    print(classification_report(y_train, y_pred))

    from sklearn.metrics import classification_report, confusion_matrix

    print(confusion_matrix(y_test, y_pred))
    print(classification_report(y_test, y_pred))

    print(knn.kneighbors(D[0]))
    print(knn.predict(D))

    # For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used

    from sklearn.metrics import classification_report, confusion_matrix

    print(confusion_matrix(X_train, y_pred))
    print(classification_report(y_test, y_pred))

    classifier.fit(X_train, y_train)

    y_pred = classifier.predict(X_test)

    from sklearn.metrics import classification_report, confusion_matrix

    print(confusion_matrix(y_test, y_pred))
    print(classification_report(y_test, y_pred))

    from sklearn.neighbors import DistanceMetric

    dt = DistanceMetric.get_metric('pyfunc', func=my_dist)

    from sklearn.neighbors import NearestNeighbors

    nbrs = NearestNeighbors(n_neighbors=4, algorithm='auto', metric='pyfunc').fit(diagramas)
    distances, indices = nbrs.kneighbors(diagramas)

    NearestNeighbors(n_neighbors=4, algorithm='auto', metric='pyfunc')

    classifier.fit(diagramas, y)


    dataset = pd.read_csv('prueba5.csv', delimiter=';', encoding='latin-1', keep_default_na=False)

    dataset['Entropy'] = [float(dataset['Entropy'][item].replace( ',', '.')) for item in range(len(dataset))]

    X = d.iloc[:, :-2].values
    y = dataset.iloc[:, 1].values
    from sklearn.model_selection import train_test_split

    # TO create training and test splits , execute the following scritp
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)

    # the above script splits the dataset into 80% and 20% test data,
    # Feature scaling
    # before making any actual predictions, it is always a good practice to scale the features so that all of them can be uniformly
    # evaluated.
    # we are going to use the gradient descent algorithm

    from sklearn.preprocessing import StandardScaler
    scaler = StandardScaler()
    scaler.fit(X_train)

    X_train = scaler.transform(X_train)
    X_test = scaler.transform(X_test)

    from sklearn.neighbors import KNeighborsClassifier

    classifier = KNeighborsClassifier(n_neighbors=40)
    classifier.fit(X_train, y_train)

    # the first step is to import the KNeighborsClassifier from library, in the second line this classifier is initialized with
    # one parameter. THis is basically the value for the K. There is no ideal value for K and it is selected after testing and evaluation

    # Final step is to make predictions on our test data. to do so, execute the following script

    y_pred = classifier.predict(X_test)

    # For evaluating the algorithm, confusion matrix, precision, recall and f1 score are the most commonly used

    from sklearn.metrics import classification_report, confusion_matrix

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

def my_dist(x ,y): x=[lis t(x[0][item]) for item in range(len(x))]
    y=[li s t(y[0][item]) for item in range(len(y))]

    return gudhi.bottleneck_distance(x,y)