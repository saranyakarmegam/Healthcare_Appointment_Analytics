#Hospital Patient & Appointment Analysis
import pandas as pd

#patients

patients = pd.read_csv("Patients.csv")

print(patients.head())
print(patients.info())
print(patients.isnull().sum())
print(patients.duplicated().sum())

#Appointments

appointments = pd.read_csv("Appointments.csv")

print(appointments.head())
print(appointments.info())
print(appointments.isnull().sum())
print(appointments.duplicated().sum())

#Departments
departments = pd.read_csv("Departments.csv")

print(departments.head())
print(departments.info())
print(departments.isnull().sum())
print(departments.duplicated().sum())

#Cleaning
appointments["Appointment_Date"] = pd.to_datetime(
    appointments["Appointment_Date"]
)

#create age groups
patients["Age_Group"] = pd.cut(
    patients["Age"],
    bins=[0, 17, 40, 60, 100],
    labels=["Child", "18-40", "41-60", "60+"]
)

#save cleaned files
patients.to_csv("cleaned_patients.csv", index=False)

appointments.to_csv("cleaned_appointments.csv",index=False)

departments.to_csv("cleaned_departments.csv",index=False)

#Display cleaned data 
print(patients.head())
pd.set_option("display.max_columns",None)
print(appointments.head())
print(departments.head())