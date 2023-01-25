from sklearn.preprocessing import StandardScaler,LabelEncoder
import pandas as pd
import joblib as jb
from scipy.stats import kurtosis
import numpy as np

my_wine = pd.read_csv('winequality_white.csv', delimiter=';') 
#drop duplicates
my_wine=my_wine.drop_duplicates()
my_wine['wine quality'] = my_wine['quality'].apply(lambda x: 'Bad' if x<=5 else 'Good' )
# Class count
count_class_0, count_class_1 = my_wine['wine quality'].value_counts()

# Divide by class
df_class_0 = my_wine[my_wine['wine quality'] == 'Good']
df_class_1 = my_wine[my_wine['wine quality'] == 'Bad']
df_class_1_over = df_class_1.sample(count_class_0, replace=True)
my_wine = pd.concat([df_class_0, df_class_1_over], axis=0)
encoder = LabelEncoder()
my_wine['wine quality'] = encoder.fit_transform(my_wine['wine quality'])

                    

# X = my_wine.drop(columns=['wine quality','pH','density','quality'])
X = my_wine.drop(columns=['quality','fixed acidity','chlorides','total sulfur dioxide','density', 'wine quality'])
y = my_wine['wine quality']
scaler = StandardScaler()
X = pd.DataFrame(scaler.fit_transform(X), columns=X.columns)
X.head()
print(X)
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.80, random_state=42)
print(X_train.shape, y_train.shape, X_test.shape, y_test.shape)
from sklearn.ensemble import RandomForestClassifier

from sklearn.metrics import r2_score,mean_squared_error
from sklearn.metrics import accuracy_score

model_rfc = RandomForestClassifier()
model_rfc.fit(X_train,y_train)

filename = 'white_wine_classifier.joblib'
jb.dump(model_rfc,filename) 
print('model saved successfully!')

