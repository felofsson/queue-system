# Queue-system for time-intense MATLAB functions

"Parallel computing over computers, not processors". Use multiple MATLAB instances to compute and organize the results of the MATLAB-functions of your choice. 

## Introduction

### The problem
Say you have a MATLAB-function ```func``` whose result depends on parameters ```a``` and ```b```. 

You run it with a set of values of the parameters and record the result. Great! You're curious, what happens if you increase ```a```? You run it again, but this time you let ```a``` be a range:

```Matlab
res = []
for a = [0:1:10]
	res(end+1) = func(a, b)
end
```

So far so good, ... **but**, what happens if ```func``` is a very time-consuming function? Or if the range of ```a``` is huge? Perhaps you are interesed in varying ```b``` aswell? 

One valiable option is to just expand the for-loop above and sit and wait. Maybe hours, or even days. If you are content with that, this project is most likely not for you.

### A possible solution

An alternative to just expanding the for-loop above into a mega-loop is to create several different loops and run them on different computers, i. e. running for the range ```a = [0:1:5]``` on one computer, and ```a = [6:1:10]``` on another.

This might save you some time, but you might run into these problems:
* How will you gather the results?
* What happens if one computer crash? How do you resume the computation?
* If you want to change the range you are sweeping, you need to **manually** change this for every MATLAB instance -- potentially this will cost you as much time as you are trying to save.

### The proposed solution - a Queue System

Imagine if you could just have a list of the commands you wish to execute, i .e.
1. ```func(0, b)```
2. ```func(1, b)```
3. ```func(2, b)```
4. etc...

And then let the a MATLAB instance view this "wish-list" and execute the first command and store its result. After completion, it moves on and takes the next item on the list. Further, imagine several MATLAB-instances working on the same wish-list: naturally you should not do the same item twice. I. e. if one instance works on item 1., the other instance should start working on the second one. 

This illustration, "wish-list", is essentially the core of this project. It is acheived by storing a set of ```.mat```-files which holds the function name to evalute, ```func``` in the examples above, a set of parameters used by ```func```. The ```.mat```-file will also hold the result of the computation.

In the beginning, all ```.mat```-files are in the same folder, a "todo"-folder. When evaluation the command, the file is move to an "active"-folder. When completed, it is moved to a "done"-folder. From this "done"-folder, it is then later possible to read and combine the results of all commands. 


## Getting Started

Download/clone the project into a new folder. Run ```main_demo.m``` cell-by-cell. It features a dummy-function that you can replace with your own code.


### Prerequisites

You need to have your own function "locked-and-loaded", i. e. debugged, optimized etc before incorporating the method proposed in this project.

More formally, your function ```func``` needs to be able to run on this form: 

```
x = func('path/to/folder/')
```

where ```x``` holds all your results and the function is able to run independently using parameters, variables etc stored in a ```.mat```-file whose location is specified by the only input argument.



## "Optimal" useage


* After getting friends with ```main_demo.m```, modify or create your own version of it. The magic line is when ```queue_system(folder_path)``` is called -- this is the line you type in all your MATLAB instances to speed up the completion of the wish-list.
* For the lazy, create an alias on your user, so that you only need to start a new terminal and run a simple command that 1. Opens MATLAB with no desktop, 2. Runs ```queue_system``` with the folder path of your choice. On UNIX-based systems, this one-liner could look like this: ```matlab -nodesktop -nojvm -r queue_system('path/to/folder/')```



## Contributing

Make a pull-request or email the author: elofsson.fredrik@gmail.com


## License

This project is licensed under the [GNU General Public Licence v3 (GPL-3)](https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)). 
