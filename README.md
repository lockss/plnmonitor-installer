# plnmonitor-installer

First, you need to configure plnmonitor:

```
./config.sh
```


This script allows the administrator to:
- set the URL for their own LOCKSS network props server (lockss.xml) 
- define the credentials to get status information for each box
- provide additional information for each box (geographical coordinates, institution, administrator,...)


Then, to bring up the plnmonitor containers (webapp, daemon and database), use:

```
./start.sh
```

The plnmonitor webapp is then available at the following URL:
[http://127.0.0.1:8084/plnmonitor-webapp](http://127.0.0.1:8084/plnmonitor-webapp)

## Requirements

### Setting a Debug User Access

On each  box in your LOCKSS network, a user should be defined to get status information from the boxes.

For obvious safety reasons, a debug user should be specifically defined for this purpose. 
In order to do that: 

- connect to the LOCKSS UI of your LOCKSS box as an administrator
- select User Accounts  on the right side menu
- enter a Username (e.g. debug) and hit the "Create User" button
- enter a password and an email address
- tick only the "View debug info" checkbox
- hit the "Add User" button

### Firewall and UI Access Control Settings

Each LOCKSS box firewall should authorize access to the user interface (typically TCP input port 8081)) for the IP address of the machine running plnmonitor.
This IP should also be authorized in the "Admin Access Control" menu of your LOCKSS box in the "Allow Access" list. 


## Known issue 

### SOAP access to LOCKSS boxes with SSL enabled
While the Daemon Status web service is directly accessible with basic authentication, when SSL is switched on, the authentication is done with a form-based login webpage and prevents using the web service. Given that the access control mechanism will be considerably improved in LAAWS, it seemed more useful to focus on the other plnmonitor features.
