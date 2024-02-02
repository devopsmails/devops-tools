#S_Example
import os

folders = input("Enter the folder path with one space to view the files : ").split()
print(folders)

for folder in folders:
     try:
        files = os.listdir(folder)
     except FileNotFoundError:
         print("\n\n***directory " + folder + " doesn't exist, Enter the valid folder***")
         continue
     
     print("\n\n****The below are the files from folder - " + folder + "*****")
     print("============================================\n")
     
     for file in files:
        print(file)
