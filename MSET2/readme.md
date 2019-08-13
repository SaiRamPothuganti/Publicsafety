
MSET2 – Multivariate State Estimation Technique

What is MSET2:
	Multivariate State Estimation Technique, MSET2, is a Oracle IP Prognostic Anomaly Detection Machine Learning Algorithm which is used for statistical functions/methods and provides us with earliest mathematically possible time before which there is an anomaly. When it comes to other Machine Learning Algorithms like Support Vector Machines, Neural Networks etc, MSET2 has better sensitivity to subtle anomalies and better accuracy in detecting Anomalies.

Prerequisites for MSET2:
	In general, for any ML process the main requirement is clean and good data for training and testing the ML model. MSET2 as well requires good data which is the data that satisfies the following prerequisites:
1. Dataset should not have NULL Values: Null values can be removed all together 
2. Dataset should not have Missing Values: Missing values should be replaced with mean values for that particular column (Imputation)
3. Training and Testing Datasets should be consistent with the number of sensors that are being used.
4. Peruse the dataset to ensure that there are no drastic outliers with the sensor readings
5. Remove all the columns that do not contribute to Machine Learning (like date column etc)

Sensor Information Collected:

Types of Sensors used:
1.	Wiolink Temperature and Humidity Sensor
2.	Wiolink Light Sensor

Data Statistics:
   Total Rows of Data: 603572
   Training Dataset: 543215 rows
   Testing Dataset: 60357 rows
   
Software Requirements:
1.	1 OCPU Compute machine 
2.	MSET2 Algorithm (JAVA Based)
3.	Jar files (in the github folder)
4.	Java Environment setup
