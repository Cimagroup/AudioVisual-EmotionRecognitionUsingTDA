#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 29 10:01:42 2021

@author: cimagroup
"""

import scipy.io as sio
import tensorflow as tf

# Loading the matrix
mat_contents = sio.loadmat("matrix_total.mat")
total_mat=mat_contents["matrix_total"]

labels = total_mat[:,8]-2
X = total_mat[:,0:7]
from sklearn.model_selection import train_test_split





x_train, x_test, y_train, y_test = train_test_split(X,labels,test_size=400)

acc_train = []
acc_test =[]

for i in range(10):

    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(1, 7)),
        tf.keras.layers.Dense(512, activation='relu'),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(7, activation='softmax')
        ])

    model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
    
    model.fit(x_train,                  
              y_train,
              epochs=500,
              validation_data=(x_test,y_test))
    acc_train.append(model.evaluate(x_train,y_train)[1])
    acc_test.append(model.evaluate(x_test,y_test)[1])
# For using tensorboard
#tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir="./logs/train_valid_9")

#Model


"""
    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(1, 7)),
        tf.keras.layers.Dense(1024, activation='relu'),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(512, activation='relu'),
        tf.keras.layers.Dropout(0.1),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dropout(0.1),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(7, activation='softmax')
        ])
"""


#model.fit(X,labels-2,epochs=500)




# Training
    
print("Sobre el conjunto de entrenamiento: ",model.evaluate(x_train,y_train))
print("Sobre el conjunto de test: ",model.evaluate(x_test,y_test))
#tf.keras.backend.clear_session()  






