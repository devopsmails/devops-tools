virtual environments =  refer to isolated Python environments, which are self-contained directories containing a specific Python installation and its associated packages.

Isolate projects
Manage dependencies
Improve reproducibility

``````
#install python virtual env
pip install virtualenv

#create virtual env projects
python -m venv project-a
python -m venv project-b

#view installed pip packes
pip list

ls

#Activate project-a virtual-env
source project-a/bin/activate
pip install maven
pip list | grep maven

To deactive virtual env
deactivate
```
