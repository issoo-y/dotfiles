# Run command file for percol

percol.import_keymap({
    "C-f" : lambda percol: percol.command.forward_char(),
    "C-b" : lambda percol: percol.command.backward_char(),
    "C-k" : lambda percol: percol.command.select_previous(),
    "C-j" : lambda percol: percol.command.select_next(),
    "C-h" : lambda percol: percol.command.delete_backward_char(),
    "C-d" : lambda percol: percol.command.delete_forward_char(),
    "C-a" : lambda percol: percol.command.beginning_of_line(),
    "C-e" : lambda percol: percol.command.end_of_line(),
    "C-v" : lambda percol: percol.command.select_next_page(),
    "M-v" : lambda percol: percol.command.select_previous_page(),
    "C-m" : lambda percol: percol.finish(),
    "C-g" : lambda percol: percol.cancel(),
})

####################################
# setting for prompt
####################################
import os
import datetime 
# get directory
home = os.path.expanduser('~')
directory = os.getcwd()
if directory.startswith(home):
    directory = directory.replace(home, '~', 1)
# get user and host name
d = datetime.datetime.today()
date = "%02d/%02d %02d:%02d:%02d" %( d.month, d.day, d.hour, d.minute, d.second)
host = os.uname()[1]
user_and_host = os.getlogin() + "@" + host
# set prompt color
color = 'cyan'
# set prompt
#percol.view.PROMPT = ur" <" + color + ur">" + directory + ur" $ %q" 
#percol.view.RPROMPT = ur" [%i/%I] " + "" + user_and_host + " " + date + ""
