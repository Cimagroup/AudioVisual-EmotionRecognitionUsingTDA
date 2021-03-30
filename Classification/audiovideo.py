#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 29 10:07:54 2021

@author: cimagroup
"""

############ AUDIO VIDEO
import scipy.io as sio
import tensorflow as tf
from sklearn.model_selection import train_test_split
mat_contents = sio.loadmat("matrix_total_audiovideo.mat")
total_mat=mat_contents["matrix_total"]

labels = total_mat[:,9]-2
X = total_mat[:,0:8]  
x_train, x_test, y_train, y_test = train_test_split(X,labels,test_size=400)

acc_train = []
acc_test =[]

for i in range(10):

    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(1, 8)),
        tf.keras.layers.Dense(512, activation='relu'),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(7, activation='softmax')
        ])

    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

#model.fit(X,labels-2,epochs=500)




# Training
    model.fit(x_train,
              y_train,
              epochs=500,
              validation_data=(x_test,y_test),
              #callbacks=[tensorboard_callback]
              )
    acc_train.append(model.evaluate(x_train,y_train)[1])
    acc_test.append(model.evaluate(x_test,y_test)[1])