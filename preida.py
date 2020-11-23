##################################################################

from sklearn.multiclass import OneVsRestClassifier, OneVsOneClassifier
from sklearn.svm import LinearSVC

OneVsRestClassifier(LinearSVC(random_state=0)).fit(X_m, y).predict(X_m)
OneVsOneClassifier(LinearSVC(random_state=0)).fit(X_m, y).predict(X_m)

from sklearn.datasets import make_multilabel_classification
from sklearn.svm import SVC

np.random.seed(42)
X, y = make_multilabel_classification(n_classes=2, n_labels=1, allow_unlabeled=True, random_state=1)
clf = OneVsRestClassifier(SVC(kernel='linear'))
clf.fit(X, y)
y_pred = clf.predict(X)
from sklearn.metrics import accuracy_score

accuracy_score(y, y_pred)