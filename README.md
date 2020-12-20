##About
A drag and drop enabled task organizer for children built with React frontend and a RESTful API connection to PostgreSQL database. With children stuck at home during the pandemic I created a web app that would help them keep their days organized and productive.

frontend repo can be found here: https://github.com/acasarsa/checkit-front

project demo: https://www.youtube.com/watch?v=FJEMCSVV7qE

###Notes on Future Changes

I would like to rework this app to better handle horizontal drag and drop between lists. I have two competing ideas for this. One is to send vertical and horizontal updates to the update_order endpoint and then use an if else statement to determine whether the list_id needs to be updated. The other option is to track the task id's of each list in state and then on update pass those id's to the update_order endpoint where the lists' tasks would then be updated. 