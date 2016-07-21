CODE BOOK
=========

1. Raw data for the exercise
=============================
The raw data for this exercise was obtained by downloading the zip file at this location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Within the zip file, the README.txt, feature_info.txt, and features.txt documents give important details about the raw data. The contents of these files are included below, as *APPENDIX: Original experiment and documentation*

2. Overview of variables in the tidy data set
=============================================
The variables in the tidy data set represent average values of a subset of the raw measurement vector provided in the download. Specifically, there are 66 variables derived from the raw measurements, and there are 2 "ID" variables that correspond to the Subject and Activity of each observation. The 66 averaged variables were selected and derived in the following way:

1. The training and test data sets were combined to form a single set of all the available data (561 variables) 
2. Only the variables corresponding to mean() and std() estimates were selected from this set (66 variables) 
3. The data set was summarized by subject and activity, and the variables were averaged by this summary 
4. The variable names were cleaned up to be more readable, for example: 
	* replacing "Gyro" with "Gyroscope" 
	* replacing "Acc" with "Accelerometer" 
	* replacing leading "t" with "Time" 
	* replacing leading "f" with "Frequency" 
	* etc.  

**REVIEWERS, PLEASE NOTE: in my interpretation of the instructions, I decided that only variables including mean() and std() would be selected.**  
For example, the following were selected:

    tBodyAcc-mean()-X  
    tBodyAcc-std()-Y  

but the following were **NOT** selected:

    fBodyAccMag-meanFreq()   
    angle(X,gravityMean)

even though the word "Mean" appears in the variable description.

3. Steps to reproduce the tidy data set
=======================================
The tidy data set can be constructed from the raw data using the R-script run_analysis.R, which was created for this assignment.  
Assumptions and requirements for run_analysis():
------------------------------------------------
1. The dplyr library is required for the function run_analysis()
2. The raw dataset must be downloaded and unzipped, so that the folder "UCI HAR Dataset" is available
3. The working directory should be set to the folder "UCI HAR Dataset"

Overview
--------
When the function run_analysis() is called, the raw data will be read from the working directory and subfolders and operated upon (described in detail below). A tidy data set will be output back to the working directory as a file named "tidydata.txt", using the write.table() function. There are no parameters required for the script to run properly. Upon completion of the script, tidydata.txt should be able to be read back into R using read.table("tidydata.txt" header=TRUE)

Detailed operation of run_analysis()
------------------------------------
### Prepare column names and activity labels  
1. Load the dplyr library
2. Read the contents of "features.txt" from the root of the working directory. This will be used to create the column names in the dataframe  
    colnames<-read.table("features.txt",header=F)
    colnames<-colnames$V2  
3. Do some text-cleanup of the names from features.txt, for readability when outputting the tidy data set
4. Read the contents of "activity_labels.txt" from the root of the working directory. The ID and label we find here will eventually be merged into our data set  

### Load the training data  
1. Read the contents of "train/X_train.txt", and name the columns in the dataframe using the information from "features.txt," above
2. Read the contents of "train/y_train.txt" which are the activity IDs for each observation
3. Read the contents of "train/subject_train.txt" which are the subject IDs for each observation
4. Column-bind these three pieces together using cbind()  

### Load the test data  
1. Read the contents of "test/X_test.txt", and name the columns in the dataframe using the information from "features.txt," above
2. Read the contents of "test/y_test.txt" which are the activity IDs for each observation
3. Read the contents of "test/subject_test.txt" which are the subject IDs for each observation
4. Column-bind these three pieces together using cbind()  

### Create the single dataframe  
1. Row bind the 2 dataframes together using rbind(). Now we have one dataframe with all of the observations (over 10,000)
2. Merge the activity labels with the single dataframe, matching the activity IDs from "activity_labels.txt" to the IDs in the dataframe  

### Select the measurements of interest  
1. Create a dataframe table (requires dplyr library) from the dataframe
2. Use select() along with grep() to choose the columns containing the measurements of mean() and std(). Drop the activity ID column, as we now have the activity name in the dataframe. **(Reviewers please note my interpretation of the selection instructions, above.)**
3. We now have a dataframe that:  
    * combines the test and training data
    * has appropriately labeled columns
    * includes subject id and descriptive activity names for each observation
    * includes only the measurements of interest  

### Create the tidy data set requested by the assignment
1. Use the group_by() function to group the dataframe table by subject_id and activity  
    * group_by(subject_id, activity)
2. Use chaining and the summarize_each() function to take the mean of every variable, summarizing by the groups  
    * summarize_each(funs(mean))
3. We now have a dataframe table that gives the average of each measurement of interest, for each subject_id and activity
4. Use write.table() to write the tidy data set to the working directory

4. Variables in the final tidy data set
===========================================
The tidy data set includes 2 ID variables and 66 measurement variables. The ID variables are:  

subject_id: an integer ID of the human participants in the experiment   

activity: a descriptive activity label, with possible values:   
    1. WALKING  
    2. WALKING_UPSTAIRS  
    3. WALKING_DOWNSTAIRS  
    4. SITTING  
    5. STANDING  
    6. LAYING 
    
The measurement variables are described in further detail in the APPENDIX, below.

Full list of varible names:

1. subject_id
2. activity
3. TimeBodyAccelerometer.mean_value.X
4. TimeBodyAccelerometer.mean_value.Y
5. TimeBodyAccelerometer.mean_value.Z
6. TimeBodyAccelerometer.std_dev.X
7. TimeBodyAccelerometer.std_dev.Y
8. TimeBodyAccelerometer.std_dev.Z
9. TimeGravityAccelerometer.mean_value.X
10. TimeGravityAccelerometer.mean_value.Y
11. TimeGravityAccelerometer.mean_value.Z
12. TimeGravityAccelerometer.std_dev.X
13. TimeGravityAccelerometer.std_dev.Y
14. TimeGravityAccelerometer.std_dev.Z
15. TimeBodyAccelerometerJerk.mean_value.X
16. TimeBodyAccelerometerJerk.mean_value.Y
17. TimeBodyAccelerometerJerk.mean_value.Z
18. TimeBodyAccelerometerJerk.std_dev.X
19. TimeBodyAccelerometerJerk.std_dev.Y
20. TimeBodyAccelerometerJerk.std_dev.Z
21. TimeBodyGyroscope.mean_value.X
22. TimeBodyGyroscope.mean_value.Y
23. TimeBodyGyroscope.mean_value.Z
24. TimeBodyGyroscope.std_dev.X
25. TimeBodyGyroscope.std_dev.Y
26. TimeBodyGyroscope.std_dev.Z
27. TimeBodyGyroscopeJerk.mean_value.X
28. TimeBodyGyroscopeJerk.mean_value.Y
29. TimeBodyGyroscopeJerk.mean_value.Z
30. TimeBodyGyroscopeJerk.std_dev.X
31. TimeBodyGyroscopeJerk.std_dev.Y
32. TimeBodyGyroscopeJerk.std_dev.Z
33. TimeBodyAccelerometerMag.mean_value
34. TimeBodyAccelerometerMag.std_dev
35. TimeGravityAccelerometerMag.mean_value
36. TimeGravityAccelerometerMag.std_dev
37. TimeBodyAccelerometerJerkMag.mean_value
38. TimeBodyAccelerometerJerkMag.std_dev
39. TimeBodyGyroscopeMag.mean_value
40. TimeBodyGyroscopeMag.std_dev
41. TimeBodyGyroscopeJerkMag.mean_value
42. TimeBodyGyroscopeJerkMag.std_dev
43. FreqBodyAccelerometer.mean_value.X
44. FreqBodyAccelerometer.mean_value.Y
45. FreqBodyAccelerometer.mean_value.Z
46. FreqBodyAccelerometer.std_dev.X
47. FreqBodyAccelerometer.std_dev.Y
48. FreqBodyAccelerometer.std_dev.Z
49. FreqBodyAccelerometerJerk.mean_value.X
50. FreqBodyAccelerometerJerk.mean_value.Y
51. FreqBodyAccelerometerJerk.mean_value.Z
52. FreqBodyAccelerometerJerk.std_dev.X
53. FreqBodyAccelerometerJerk.std_dev.Y
54. FreqBodyAccelerometerJerk.std_dev.Z
55. FreqBodyGyroscope.mean_value.X
56. FreqBodyGyroscope.mean_value.Y
57. FreqBodyGyroscope.mean_value.Z
58. FreqBodyGyroscope.std_dev.X
59. FreqBodyGyroscope.std_dev.Y
60. FreqBodyGyroscope.std_dev.Z
61. FreqBodyAccelerometerMag.mean_value
62. FreqBodyAccelerometerMag.std_dev
63. FreqBodyBodyAccelerometerJerkMag.mean_value
64. FreqBodyBodyAccelerometerJerkMag.std_dev
65. FreqBodyBodyGyroscopeMag.mean_value
66. FreqBodyBodyGyroscopeMag.std_dev
67. FreqBodyBodyGyroscopeJerkMag.mean_value
68. FreqBodyBodyGyroscopeJerkMag.std_dev



APPENDIX: Original experiment and documentation
===============================================

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt' (and listed below):

1. tBodyAcc-mean()-X
2. tBodyAcc-mean()-Y
3. tBodyAcc-mean()-Z
4. tBodyAcc-std()-X
5. tBodyAcc-std()-Y
6. tBodyAcc-std()-Z
7. tBodyAcc-mad()-X
8. tBodyAcc-mad()-Y
9. tBodyAcc-mad()-Z
10. tBodyAcc-max()-X
11. tBodyAcc-max()-Y
12. tBodyAcc-max()-Z
13. tBodyAcc-min()-X
14. tBodyAcc-min()-Y
15. tBodyAcc-min()-Z
16. tBodyAcc-sma()
17. tBodyAcc-energy()-X
18. tBodyAcc-energy()-Y
19. tBodyAcc-energy()-Z
20. tBodyAcc-iqr()-X
21. tBodyAcc-iqr()-Y
22. tBodyAcc-iqr()-Z
23. tBodyAcc-entropy()-X
24. tBodyAcc-entropy()-Y
25. tBodyAcc-entropy()-Z
26. tBodyAcc-arCoeff()-X,1
27. tBodyAcc-arCoeff()-X,2
28. tBodyAcc-arCoeff()-X,3
29. tBodyAcc-arCoeff()-X,4
30. tBodyAcc-arCoeff()-Y,1
31. tBodyAcc-arCoeff()-Y,2
32. tBodyAcc-arCoeff()-Y,3
33. tBodyAcc-arCoeff()-Y,4
34. tBodyAcc-arCoeff()-Z,1
35. tBodyAcc-arCoeff()-Z,2
36. tBodyAcc-arCoeff()-Z,3
37. tBodyAcc-arCoeff()-Z,4
38. tBodyAcc-correlation()-X,Y
39. tBodyAcc-correlation()-X,Z
40. tBodyAcc-correlation()-Y,Z
41. tGravityAcc-mean()-X
42. tGravityAcc-mean()-Y
43. tGravityAcc-mean()-Z
44. tGravityAcc-std()-X
45. tGravityAcc-std()-Y
46. tGravityAcc-std()-Z
47. tGravityAcc-mad()-X
48. tGravityAcc-mad()-Y
49. tGravityAcc-mad()-Z
50. tGravityAcc-max()-X
51. tGravityAcc-max()-Y
52. tGravityAcc-max()-Z
53. tGravityAcc-min()-X
54. tGravityAcc-min()-Y
55. tGravityAcc-min()-Z
56. tGravityAcc-sma()
57. tGravityAcc-energy()-X
58. tGravityAcc-energy()-Y
59. tGravityAcc-energy()-Z
60. tGravityAcc-iqr()-X
61. tGravityAcc-iqr()-Y
62. tGravityAcc-iqr()-Z
63. tGravityAcc-entropy()-X
64. tGravityAcc-entropy()-Y
65. tGravityAcc-entropy()-Z
66. tGravityAcc-arCoeff()-X,1
67. tGravityAcc-arCoeff()-X,2
68. tGravityAcc-arCoeff()-X,3
69. tGravityAcc-arCoeff()-X,4
70. tGravityAcc-arCoeff()-Y,1
71. tGravityAcc-arCoeff()-Y,2
72. tGravityAcc-arCoeff()-Y,3
73. tGravityAcc-arCoeff()-Y,4
74. tGravityAcc-arCoeff()-Z,1
75. tGravityAcc-arCoeff()-Z,2
76. tGravityAcc-arCoeff()-Z,3
77. tGravityAcc-arCoeff()-Z,4
78. tGravityAcc-correlation()-X,Y
79. tGravityAcc-correlation()-X,Z
80. tGravityAcc-correlation()-Y,Z
81. tBodyAccJerk-mean()-X
82. tBodyAccJerk-mean()-Y
83. tBodyAccJerk-mean()-Z
84. tBodyAccJerk-std()-X
85. tBodyAccJerk-std()-Y
86. tBodyAccJerk-std()-Z
87. tBodyAccJerk-mad()-X
88. tBodyAccJerk-mad()-Y
89. tBodyAccJerk-mad()-Z
90. tBodyAccJerk-max()-X
91. tBodyAccJerk-max()-Y
92. tBodyAccJerk-max()-Z
93. tBodyAccJerk-min()-X
94. tBodyAccJerk-min()-Y
95. tBodyAccJerk-min()-Z
96. tBodyAccJerk-sma()
97. tBodyAccJerk-energy()-X
98. tBodyAccJerk-energy()-Y
99. tBodyAccJerk-energy()-Z
100. tBodyAccJerk-iqr()-X
101. tBodyAccJerk-iqr()-Y
102. tBodyAccJerk-iqr()-Z
103. tBodyAccJerk-entropy()-X
104. tBodyAccJerk-entropy()-Y
105. tBodyAccJerk-entropy()-Z
106. tBodyAccJerk-arCoeff()-X,1
107. tBodyAccJerk-arCoeff()-X,2
108. tBodyAccJerk-arCoeff()-X,3
109. tBodyAccJerk-arCoeff()-X,4
110. tBodyAccJerk-arCoeff()-Y,1
111. tBodyAccJerk-arCoeff()-Y,2
112. tBodyAccJerk-arCoeff()-Y,3
113. tBodyAccJerk-arCoeff()-Y,4
114. tBodyAccJerk-arCoeff()-Z,1
115. tBodyAccJerk-arCoeff()-Z,2
116. tBodyAccJerk-arCoeff()-Z,3
117. tBodyAccJerk-arCoeff()-Z,4
118. tBodyAccJerk-correlation()-X,Y
119. tBodyAccJerk-correlation()-X,Z
120. tBodyAccJerk-correlation()-Y,Z
121. tBodyGyro-mean()-X
122. tBodyGyro-mean()-Y
123. tBodyGyro-mean()-Z
124. tBodyGyro-std()-X
125. tBodyGyro-std()-Y
126. tBodyGyro-std()-Z
127. tBodyGyro-mad()-X
128. tBodyGyro-mad()-Y
129. tBodyGyro-mad()-Z
130. tBodyGyro-max()-X
131. tBodyGyro-max()-Y
132. tBodyGyro-max()-Z
133. tBodyGyro-min()-X
134. tBodyGyro-min()-Y
135. tBodyGyro-min()-Z
136. tBodyGyro-sma()
137. tBodyGyro-energy()-X
138. tBodyGyro-energy()-Y
139. tBodyGyro-energy()-Z
140. tBodyGyro-iqr()-X
141. tBodyGyro-iqr()-Y
142. tBodyGyro-iqr()-Z
143. tBodyGyro-entropy()-X
144. tBodyGyro-entropy()-Y
145. tBodyGyro-entropy()-Z
146. tBodyGyro-arCoeff()-X,1
147. tBodyGyro-arCoeff()-X,2
148. tBodyGyro-arCoeff()-X,3
149. tBodyGyro-arCoeff()-X,4
150. tBodyGyro-arCoeff()-Y,1
151. tBodyGyro-arCoeff()-Y,2
152. tBodyGyro-arCoeff()-Y,3
153. tBodyGyro-arCoeff()-Y,4
154. tBodyGyro-arCoeff()-Z,1
155. tBodyGyro-arCoeff()-Z,2
156. tBodyGyro-arCoeff()-Z,3
157. tBodyGyro-arCoeff()-Z,4
158. tBodyGyro-correlation()-X,Y
159. tBodyGyro-correlation()-X,Z
160. tBodyGyro-correlation()-Y,Z
161. tBodyGyroJerk-mean()-X
162. tBodyGyroJerk-mean()-Y
163. tBodyGyroJerk-mean()-Z
164. tBodyGyroJerk-std()-X
165. tBodyGyroJerk-std()-Y
166. tBodyGyroJerk-std()-Z
167. tBodyGyroJerk-mad()-X
168. tBodyGyroJerk-mad()-Y
169. tBodyGyroJerk-mad()-Z
170. tBodyGyroJerk-max()-X
171. tBodyGyroJerk-max()-Y
172. tBodyGyroJerk-max()-Z
173. tBodyGyroJerk-min()-X
174. tBodyGyroJerk-min()-Y
175. tBodyGyroJerk-min()-Z
176. tBodyGyroJerk-sma()
177. tBodyGyroJerk-energy()-X
178. tBodyGyroJerk-energy()-Y
179. tBodyGyroJerk-energy()-Z
180. tBodyGyroJerk-iqr()-X
181. tBodyGyroJerk-iqr()-Y
182. tBodyGyroJerk-iqr()-Z
183. tBodyGyroJerk-entropy()-X
184. tBodyGyroJerk-entropy()-Y
185. tBodyGyroJerk-entropy()-Z
186. tBodyGyroJerk-arCoeff()-X,1
187. tBodyGyroJerk-arCoeff()-X,2
188. tBodyGyroJerk-arCoeff()-X,3
189. tBodyGyroJerk-arCoeff()-X,4
190. tBodyGyroJerk-arCoeff()-Y,1
191. tBodyGyroJerk-arCoeff()-Y,2
192. tBodyGyroJerk-arCoeff()-Y,3
193. tBodyGyroJerk-arCoeff()-Y,4
194. tBodyGyroJerk-arCoeff()-Z,1
195. tBodyGyroJerk-arCoeff()-Z,2
196. tBodyGyroJerk-arCoeff()-Z,3
197. tBodyGyroJerk-arCoeff()-Z,4
198. tBodyGyroJerk-correlation()-X,Y
199. tBodyGyroJerk-correlation()-X,Z
200. tBodyGyroJerk-correlation()-Y,Z
201. tBodyAccMag-mean()
202. tBodyAccMag-std()
203. tBodyAccMag-mad()
204. tBodyAccMag-max()
205. tBodyAccMag-min()
206. tBodyAccMag-sma()
207. tBodyAccMag-energy()
208. tBodyAccMag-iqr()
209. tBodyAccMag-entropy()
210. tBodyAccMag-arCoeff()1
211. tBodyAccMag-arCoeff()2
212. tBodyAccMag-arCoeff()3
213. tBodyAccMag-arCoeff()4
214. tGravityAccMag-mean()
215. tGravityAccMag-std()
216. tGravityAccMag-mad()
217. tGravityAccMag-max()
218. tGravityAccMag-min()
219. tGravityAccMag-sma()
220. tGravityAccMag-energy()
221. tGravityAccMag-iqr()
222. tGravityAccMag-entropy()
223. tGravityAccMag-arCoeff()1
224. tGravityAccMag-arCoeff()2
225. tGravityAccMag-arCoeff()3
226. tGravityAccMag-arCoeff()4
227. tBodyAccJerkMag-mean()
228. tBodyAccJerkMag-std()
229. tBodyAccJerkMag-mad()
230. tBodyAccJerkMag-max()
231. tBodyAccJerkMag-min()
232. tBodyAccJerkMag-sma()
233. tBodyAccJerkMag-energy()
234. tBodyAccJerkMag-iqr()
235. tBodyAccJerkMag-entropy()
236. tBodyAccJerkMag-arCoeff()1
237. tBodyAccJerkMag-arCoeff()2
238. tBodyAccJerkMag-arCoeff()3
239. tBodyAccJerkMag-arCoeff()4
240. tBodyGyroMag-mean()
241. tBodyGyroMag-std()
242. tBodyGyroMag-mad()
243. tBodyGyroMag-max()
244. tBodyGyroMag-min()
245. tBodyGyroMag-sma()
246. tBodyGyroMag-energy()
247. tBodyGyroMag-iqr()
248. tBodyGyroMag-entropy()
249. tBodyGyroMag-arCoeff()1
250. tBodyGyroMag-arCoeff()2
251. tBodyGyroMag-arCoeff()3
252. tBodyGyroMag-arCoeff()4
253. tBodyGyroJerkMag-mean()
254. tBodyGyroJerkMag-std()
255. tBodyGyroJerkMag-mad()
256. tBodyGyroJerkMag-max()
257. tBodyGyroJerkMag-min()
258. tBodyGyroJerkMag-sma()
259. tBodyGyroJerkMag-energy()
260. tBodyGyroJerkMag-iqr()
261. tBodyGyroJerkMag-entropy()
262. tBodyGyroJerkMag-arCoeff()1
263. tBodyGyroJerkMag-arCoeff()2
264. tBodyGyroJerkMag-arCoeff()3
265. tBodyGyroJerkMag-arCoeff()4
266. fBodyAcc-mean()-X
267. fBodyAcc-mean()-Y
268. fBodyAcc-mean()-Z
269. fBodyAcc-std()-X
270. fBodyAcc-std()-Y
271. fBodyAcc-std()-Z
272. fBodyAcc-mad()-X
273. fBodyAcc-mad()-Y
274. fBodyAcc-mad()-Z
275. fBodyAcc-max()-X
276. fBodyAcc-max()-Y
277. fBodyAcc-max()-Z
278. fBodyAcc-min()-X
279. fBodyAcc-min()-Y
280. fBodyAcc-min()-Z
281. fBodyAcc-sma()
282. fBodyAcc-energy()-X
283. fBodyAcc-energy()-Y
284. fBodyAcc-energy()-Z
285. fBodyAcc-iqr()-X
286. fBodyAcc-iqr()-Y
287. fBodyAcc-iqr()-Z
288. fBodyAcc-entropy()-X
289. fBodyAcc-entropy()-Y
290. fBodyAcc-entropy()-Z
291. fBodyAcc-maxInds-X
292. fBodyAcc-maxInds-Y
293. fBodyAcc-maxInds-Z
294. fBodyAcc-meanFreq()-X
295. fBodyAcc-meanFreq()-Y
296. fBodyAcc-meanFreq()-Z
297. fBodyAcc-skewness()-X
298. fBodyAcc-kurtosis()-X
299. fBodyAcc-skewness()-Y
300. fBodyAcc-kurtosis()-Y
301. fBodyAcc-skewness()-Z
302. fBodyAcc-kurtosis()-Z
303. fBodyAcc-bandsEnergy()-1,8
304. fBodyAcc-bandsEnergy()-9,16
305. fBodyAcc-bandsEnergy()-17,24
306. fBodyAcc-bandsEnergy()-25,32
307. fBodyAcc-bandsEnergy()-33,40
308. fBodyAcc-bandsEnergy()-41,48
309. fBodyAcc-bandsEnergy()-49,56
310. fBodyAcc-bandsEnergy()-57,64
311. fBodyAcc-bandsEnergy()-1,16
312. fBodyAcc-bandsEnergy()-17,32
313. fBodyAcc-bandsEnergy()-33,48
314. fBodyAcc-bandsEnergy()-49,64
315. fBodyAcc-bandsEnergy()-1,24
316. fBodyAcc-bandsEnergy()-25,48
317. fBodyAcc-bandsEnergy()-1,8
318. fBodyAcc-bandsEnergy()-9,16
319. fBodyAcc-bandsEnergy()-17,24
320. fBodyAcc-bandsEnergy()-25,32
321. fBodyAcc-bandsEnergy()-33,40
322. fBodyAcc-bandsEnergy()-41,48
323. fBodyAcc-bandsEnergy()-49,56
324. fBodyAcc-bandsEnergy()-57,64
325. fBodyAcc-bandsEnergy()-1,16
326. fBodyAcc-bandsEnergy()-17,32
327. fBodyAcc-bandsEnergy()-33,48
328. fBodyAcc-bandsEnergy()-49,64
329. fBodyAcc-bandsEnergy()-1,24
330. fBodyAcc-bandsEnergy()-25,48
331. fBodyAcc-bandsEnergy()-1,8
332. fBodyAcc-bandsEnergy()-9,16
333. fBodyAcc-bandsEnergy()-17,24
334. fBodyAcc-bandsEnergy()-25,32
335. fBodyAcc-bandsEnergy()-33,40
336. fBodyAcc-bandsEnergy()-41,48
337. fBodyAcc-bandsEnergy()-49,56
338. fBodyAcc-bandsEnergy()-57,64
339. fBodyAcc-bandsEnergy()-1,16
340. fBodyAcc-bandsEnergy()-17,32
341. fBodyAcc-bandsEnergy()-33,48
342. fBodyAcc-bandsEnergy()-49,64
343. fBodyAcc-bandsEnergy()-1,24
344. fBodyAcc-bandsEnergy()-25,48
345. fBodyAccJerk-mean()-X
346. fBodyAccJerk-mean()-Y
347. fBodyAccJerk-mean()-Z
348. fBodyAccJerk-std()-X
349. fBodyAccJerk-std()-Y
350. fBodyAccJerk-std()-Z
351. fBodyAccJerk-mad()-X
352. fBodyAccJerk-mad()-Y
353. fBodyAccJerk-mad()-Z
354. fBodyAccJerk-max()-X
355. fBodyAccJerk-max()-Y
356. fBodyAccJerk-max()-Z
357. fBodyAccJerk-min()-X
358. fBodyAccJerk-min()-Y
359. fBodyAccJerk-min()-Z
360. fBodyAccJerk-sma()
361. fBodyAccJerk-energy()-X
362. fBodyAccJerk-energy()-Y
363. fBodyAccJerk-energy()-Z
364. fBodyAccJerk-iqr()-X
365. fBodyAccJerk-iqr()-Y
366. fBodyAccJerk-iqr()-Z
367. fBodyAccJerk-entropy()-X
368. fBodyAccJerk-entropy()-Y
369. fBodyAccJerk-entropy()-Z
370. fBodyAccJerk-maxInds-X
371. fBodyAccJerk-maxInds-Y
372. fBodyAccJerk-maxInds-Z
373. fBodyAccJerk-meanFreq()-X
374. fBodyAccJerk-meanFreq()-Y
375. fBodyAccJerk-meanFreq()-Z
376. fBodyAccJerk-skewness()-X
377. fBodyAccJerk-kurtosis()-X
378. fBodyAccJerk-skewness()-Y
379. fBodyAccJerk-kurtosis()-Y
380. fBodyAccJerk-skewness()-Z
381. fBodyAccJerk-kurtosis()-Z
382. fBodyAccJerk-bandsEnergy()-1,8
383. fBodyAccJerk-bandsEnergy()-9,16
384. fBodyAccJerk-bandsEnergy()-17,24
385. fBodyAccJerk-bandsEnergy()-25,32
386. fBodyAccJerk-bandsEnergy()-33,40
387. fBodyAccJerk-bandsEnergy()-41,48
388. fBodyAccJerk-bandsEnergy()-49,56
389. fBodyAccJerk-bandsEnergy()-57,64
390. fBodyAccJerk-bandsEnergy()-1,16
391. fBodyAccJerk-bandsEnergy()-17,32
392. fBodyAccJerk-bandsEnergy()-33,48
393. fBodyAccJerk-bandsEnergy()-49,64
394. fBodyAccJerk-bandsEnergy()-1,24
395. fBodyAccJerk-bandsEnergy()-25,48
396. fBodyAccJerk-bandsEnergy()-1,8
397. fBodyAccJerk-bandsEnergy()-9,16
398. fBodyAccJerk-bandsEnergy()-17,24
399. fBodyAccJerk-bandsEnergy()-25,32
400. fBodyAccJerk-bandsEnergy()-33,40
401. fBodyAccJerk-bandsEnergy()-41,48
402. fBodyAccJerk-bandsEnergy()-49,56
403. fBodyAccJerk-bandsEnergy()-57,64
404. fBodyAccJerk-bandsEnergy()-1,16
405. fBodyAccJerk-bandsEnergy()-17,32
406. fBodyAccJerk-bandsEnergy()-33,48
407. fBodyAccJerk-bandsEnergy()-49,64
408. fBodyAccJerk-bandsEnergy()-1,24
409. fBodyAccJerk-bandsEnergy()-25,48
410. fBodyAccJerk-bandsEnergy()-1,8
411. fBodyAccJerk-bandsEnergy()-9,16
412. fBodyAccJerk-bandsEnergy()-17,24
413. fBodyAccJerk-bandsEnergy()-25,32
414. fBodyAccJerk-bandsEnergy()-33,40
415. fBodyAccJerk-bandsEnergy()-41,48
416. fBodyAccJerk-bandsEnergy()-49,56
417. fBodyAccJerk-bandsEnergy()-57,64
418. fBodyAccJerk-bandsEnergy()-1,16
419. fBodyAccJerk-bandsEnergy()-17,32
420. fBodyAccJerk-bandsEnergy()-33,48
421. fBodyAccJerk-bandsEnergy()-49,64
422. fBodyAccJerk-bandsEnergy()-1,24
423. fBodyAccJerk-bandsEnergy()-25,48
424. fBodyGyro-mean()-X
425. fBodyGyro-mean()-Y
426. fBodyGyro-mean()-Z
427. fBodyGyro-std()-X
428. fBodyGyro-std()-Y
429. fBodyGyro-std()-Z
430. fBodyGyro-mad()-X
431. fBodyGyro-mad()-Y
432. fBodyGyro-mad()-Z
433. fBodyGyro-max()-X
434. fBodyGyro-max()-Y
435. fBodyGyro-max()-Z
436. fBodyGyro-min()-X
437. fBodyGyro-min()-Y
438. fBodyGyro-min()-Z
439. fBodyGyro-sma()
440. fBodyGyro-energy()-X
441. fBodyGyro-energy()-Y
442. fBodyGyro-energy()-Z
443. fBodyGyro-iqr()-X
444. fBodyGyro-iqr()-Y
445. fBodyGyro-iqr()-Z
446. fBodyGyro-entropy()-X
447. fBodyGyro-entropy()-Y
448. fBodyGyro-entropy()-Z
449. fBodyGyro-maxInds-X
450. fBodyGyro-maxInds-Y
451. fBodyGyro-maxInds-Z
452. fBodyGyro-meanFreq()-X
453. fBodyGyro-meanFreq()-Y
454. fBodyGyro-meanFreq()-Z
455. fBodyGyro-skewness()-X
456. fBodyGyro-kurtosis()-X
457. fBodyGyro-skewness()-Y
458. fBodyGyro-kurtosis()-Y
459. fBodyGyro-skewness()-Z
460. fBodyGyro-kurtosis()-Z
461. fBodyGyro-bandsEnergy()-1,8
462. fBodyGyro-bandsEnergy()-9,16
463. fBodyGyro-bandsEnergy()-17,24
464. fBodyGyro-bandsEnergy()-25,32
465. fBodyGyro-bandsEnergy()-33,40
466. fBodyGyro-bandsEnergy()-41,48
467. fBodyGyro-bandsEnergy()-49,56
468. fBodyGyro-bandsEnergy()-57,64
469. fBodyGyro-bandsEnergy()-1,16
470. fBodyGyro-bandsEnergy()-17,32
471. fBodyGyro-bandsEnergy()-33,48
472. fBodyGyro-bandsEnergy()-49,64
473. fBodyGyro-bandsEnergy()-1,24
474. fBodyGyro-bandsEnergy()-25,48
475. fBodyGyro-bandsEnergy()-1,8
476. fBodyGyro-bandsEnergy()-9,16
477. fBodyGyro-bandsEnergy()-17,24
478. fBodyGyro-bandsEnergy()-25,32
479. fBodyGyro-bandsEnergy()-33,40
480. fBodyGyro-bandsEnergy()-41,48
481. fBodyGyro-bandsEnergy()-49,56
482. fBodyGyro-bandsEnergy()-57,64
483. fBodyGyro-bandsEnergy()-1,16
484. fBodyGyro-bandsEnergy()-17,32
485. fBodyGyro-bandsEnergy()-33,48
486. fBodyGyro-bandsEnergy()-49,64
487. fBodyGyro-bandsEnergy()-1,24
488. fBodyGyro-bandsEnergy()-25,48
489. fBodyGyro-bandsEnergy()-1,8
490. fBodyGyro-bandsEnergy()-9,16
491. fBodyGyro-bandsEnergy()-17,24
492. fBodyGyro-bandsEnergy()-25,32
493. fBodyGyro-bandsEnergy()-33,40
494. fBodyGyro-bandsEnergy()-41,48
495. fBodyGyro-bandsEnergy()-49,56
496. fBodyGyro-bandsEnergy()-57,64
497. fBodyGyro-bandsEnergy()-1,16
498. fBodyGyro-bandsEnergy()-17,32
499. fBodyGyro-bandsEnergy()-33,48
500. fBodyGyro-bandsEnergy()-49,64
501. fBodyGyro-bandsEnergy()-1,24
502. fBodyGyro-bandsEnergy()-25,48
503. fBodyAccMag-mean()
504. fBodyAccMag-std()
505. fBodyAccMag-mad()
506. fBodyAccMag-max()
507. fBodyAccMag-min()
508. fBodyAccMag-sma()
509. fBodyAccMag-energy()
510. fBodyAccMag-iqr()
511. fBodyAccMag-entropy()
512. fBodyAccMag-maxInds
513. fBodyAccMag-meanFreq()
514. fBodyAccMag-skewness()
515. fBodyAccMag-kurtosis()
516. fBodyBodyAccJerkMag-mean()
517. fBodyBodyAccJerkMag-std()
518. fBodyBodyAccJerkMag-mad()
519. fBodyBodyAccJerkMag-max()
520. fBodyBodyAccJerkMag-min()
521. fBodyBodyAccJerkMag-sma()
522. fBodyBodyAccJerkMag-energy()
523. fBodyBodyAccJerkMag-iqr()
524. fBodyBodyAccJerkMag-entropy()
525. fBodyBodyAccJerkMag-maxInds
526. fBodyBodyAccJerkMag-meanFreq()
527. fBodyBodyAccJerkMag-skewness()
528. fBodyBodyAccJerkMag-kurtosis()
529. fBodyBodyGyroMag-mean()
530. fBodyBodyGyroMag-std()
531. fBodyBodyGyroMag-mad()
532. fBodyBodyGyroMag-max()
533. fBodyBodyGyroMag-min()
534. fBodyBodyGyroMag-sma()
535. fBodyBodyGyroMag-energy()
536. fBodyBodyGyroMag-iqr()
537. fBodyBodyGyroMag-entropy()
538. fBodyBodyGyroMag-maxInds
539. fBodyBodyGyroMag-meanFreq()
540. fBodyBodyGyroMag-skewness()
541. fBodyBodyGyroMag-kurtosis()
542. fBodyBodyGyroJerkMag-mean()
543. fBodyBodyGyroJerkMag-std()
544. fBodyBodyGyroJerkMag-mad()
545. fBodyBodyGyroJerkMag-max()
546. fBodyBodyGyroJerkMag-min()
547. fBodyBodyGyroJerkMag-sma()
548. fBodyBodyGyroJerkMag-energy()
549. fBodyBodyGyroJerkMag-iqr()
550. fBodyBodyGyroJerkMag-entropy()
551. fBodyBodyGyroJerkMag-maxInds
552. fBodyBodyGyroJerkMag-meanFreq()
553. fBodyBodyGyroJerkMag-skewness()
554. fBodyBodyGyroJerkMag-kurtosis()
555. angle(tBodyAccMean,gravity)
556. angle(tBodyAccJerkMean),gravityMean)
557. angle(tBodyGyroMean,gravityMean)
558. angle(tBodyGyroJerkMean,gravityMean)
559. angle(X,gravityMean)
560. angle(Y,gravityMean)
561. angle(Z,gravityMean)
