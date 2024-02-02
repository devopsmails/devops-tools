#***Creating Env vars***

export username="suresh"
export dev_password="abc123"

#Deleting the env vars#
unset dev_password

#invoking the env vars in programme

import os

print(os.getenv("username"))
print(os.getenv("dev_password"))
