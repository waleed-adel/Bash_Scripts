#!/bin/bash

#GLobal Variables that is used to store the input from the user
export CONTACT_NAMES
export CONTACT_NUMBERS


#check on the first argument passed to the script
case $1 in 

#if no option (argument) is passed then the script will list the available options 
"")

echo "You Have 5 Options To Choose From"
echo "1- phonebook -i [to insert a new contact]"
echo "2- phonebook -v [to view all contacts]"
echo "3- phonebook -s [to search for a contact by name]"
echo "4- phonebook -e [to delete all contacts]"
echo "5- phonebook -d [to delete one contact only]" 
echo "NOTE: YOU HAVE TO LOGIN AS SUDO USER FIRSTLY" ;;

#***1st option***
#if "-i" is passed then the user wants to add a new entry [contact] to the list
"-i")
  
read -p "Please Enter The Name: " CONTACT_NAMES
read -p "Please Enter The Number: " CONTACT_NUMBERS
#if user inputs a string, the var. [CONTACT_NUMBERS] will be equal must be re-entered
#the var. below will store anything other than numbers 0-9
check_for_alphapets="$(echo $CONTACT_NUMBERS | grep [^0-9])" 
while [ "$check_for_alphapets" ]
do 
echo "INVALID NUMBER ENTRY!!"
read -p "PLEASE ENTER A VALID INTEGER NUMBER: " CONTACT_NUMBERS
check_for_alphapets="$(echo $CONTACT_NUMBERS | grep [^0-9])" 
done
#echo -e so we can use the tab (\t) instead of printing \t
# (>>) will append the output at the end of the specified file
# to use >> you need to be a sudo user
#the format appended is: # Name: entered_name[couble of spaces :D]Number: entered_number
echo -e "# Name: $CONTACT_NAMES\t\tNumber: $CONTACT_NUMBERS" >> phonebook.sh ;;


#***2nd option***
#if "-v" is passed then the user wants to display the contact list
"-v")

contact="$(grep "^# Name:\s\w\+\s\+Number:\s\w\+" phonebook.sh)"
#check to see if there is any contact in the database or it's empty
if [ "$contact" ]
then 
grep "^# Name:\s\w.*\s\+\Number:\s\w\+" phonebook.sh
else
echo "THE LIST IS EMPTY :D"
fi ;;


#***3rd option***
#if "-s" is passed then the user wants to search for a name in the contact list
"-s")

contact="$(grep "^# Name:\s\w\+\s\+Number:\s\w\+" phonebook.sh)"
#check to see if there is any contact in the database or it's empty
if [ "$contact" ]
then 
#first ask user to enter the name he wants to search for
read -p "Please Enter The Name You Want to Search For: " search_name
#second, redirect output of grep command to a variable then check if there is a match or not
found="$(grep "^# Name:\s$search_name\s\+Number:\s\w\+" phonebook.sh)"
if [ "$found" ] 
then
echo "A Match Has Been Found"
printf "%s\n" "$found"
else 
echo "NAME ENTERED NOT FOUND!!"
fi 
else
echo "THE LIST IS EMPTY :D"
fi ;;

#***4th option***
#if "-e" is passed then the user wants to delete all the list
"-e")

contact="$(grep "^# Name:\s\w\+\s\+Number:\s\w\+" phonebook.sh)"
#check to see if there is any contact in the database or it's empty
if [ "$contact" ]
then 
#deleting the database placed at the end of the file
#sed command is used to delete lines from a file
#use sed -i to delete the lines from the source file
#for example: sed -i '/^s/,$d' is used to delete the lines from:
#the line that starts with character 's'[/^s/] till last line [$d]
sed -i '/^# Name:/,$d' phonebook.sh 
echo "LIST DELETED SUCCESSFULLY" 
else
echo "THE LIST IS EMPTY :D"
fi ;;

#***5th option***
#if "-d" is passed then the user wants to delete only one contact from the list
"-d")

contact="$(grep "^# Name:\s\w\+\s\+Number:\s\w\+" phonebook.sh)"
#check to see if there is any contact in the database or it's empty
if [ "$contact" ]
then 
#first ask user to enter the name he wants to search for then delete it
read -p "Please Enter The Name You Want to Search For: " search_name
#second, redirect output of grep command to a variable then check if there is a match or not
found="$(grep "Name:\s$search_name\s\+Number:\s\w\+" phonebook.sh)"
if [ "$found" ]
then
#delete the line containing the contact from database
#sed -i '/pattern/d' will delete any line containing that pattern
#if the pattern is a string stored in a variable then use the below format
sed -i '/# Name:\s\'$(echo $search_name)'\b\s\+\Number:/d' phonebook.sh
echo "CONTACT DELETED SUCCESSFULLY"
else 
echo "NAME ENTERED NOT FOUND!!"
fi 
else
echo "THE LIST IS EMPTY :D"
fi ;;

#if any other argument is entered as an option
*)

echo "INVALID OPTION!!"

esac

####################################
###******PhoneBook DataBase******###

