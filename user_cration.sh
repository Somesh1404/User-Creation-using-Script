#!/bin/bash
#Script should be execute only with sudo / root access.
if [[ "${UID}" -ne 0 ]]
then
        echo 'Please login with root or sudo user'
        exit 1
fi

#user should provide at lest one argument as username else guid them

if [[ "${#}" -lt 1 ]]
then
        echo "Usage: ${0} User_Name [Comment]..."
        echo 'Create a user with name User_Name and comment field of comment'
        exit 1
fi

#Store 1st Argument as user name
USER_NAME="${1}"
echo $USER_NAME

#Incase of more then one agrument, store it as a account comment
shift
COMMENT="${@}"

#Create a password
PASSWORD=$(date +%s%N)


#Create the user
useradd -c "${COMMENT}" -m $USER_NAME


#Check if the user is successfully created or not 
if [[ $? -ne 0 ]]
then    
        echo 'The Account is not created'
        exit 1
fi

#set the password for the user 
echo $PASSWORD | passwd --stdin $USER_NAME


#Chceck if the password is successfully set of not 

if [[ $? -ne 0 ]]
then
        echo 'The password is not set'  
        exit 1
fi


#Force password change on first login
passwd -e $USER_NAME

#Display the username, password and the host were the user is created 

echo 
echo "Username: $USER_NAME"
echo 
echo "Passsword: $PASSWORD"
64 lines yanked                 