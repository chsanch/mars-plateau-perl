## Coding Problem:

A squad of robotic rovers are to be landed by NASA on a plateau on Mars.
This plateau, which is curiously rectangular, must be navigated by
the rovers so that their on-board cameras can get a complete view of the
surrounding terrain to send back to Earth. A rover’s position and location
is represented by a combination of x and y co- ordinates and a letter
representing one of the four cardinal compass points. The plateau is
divided up into a grid to simplify navigation.

An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.In order to control a rover, NASA sends a simple string of letters. The possible letters are ‘L’, ‘R’ and ‘M’. ‘L’ and ‘R’ makes the rover spin 90 degrees left or right respectively, without moving from its current spot. ‘M’ means move forward one grid point, and maintain the
same Heading. Assume that the square directly North from (x, y) is (x, y+1).

### INPUT:
The first line of input is the upper-right coordinates of the plateau, the lower- left coordinates are assumed to be 0,0. The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover’s position, and the second line is a series of instructions telling the rover how to explore the plateau. The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and therover’s orientation. Each rover will be finished sequentially, which means that the
second rover won’t start to move until the first one has finished moving.

### OUTPUT:
 The output for each rover should be its final co-ordinates and heading.

### INPUT AND OUTPUT:
Test Input:
```
5 5
1 2 N
L M L M L M L M M
3 3 E
M M R M M R M R R M
```
Expected Output:
```
1 3 N 
5 1 E
```

## Proposed solution

This solution is based on Perl, to run it is recommended to use [plenv](https://github.com/tokuhirom/plenv) to install a Perl version and the two dependencies needed: [Moose](https://metacpan.org/pod/Moose) and  [Modern::Perl](https://metacpan.org/pod/Modern::Perl)

After installing `plenv` proceed to install a new version of Perl (to avoid handling the dependencies on the system Perl), i.e.:

```
plenv install 5.32.1
``` 
set this versions as the default (or local just for this directory):

```
plenv global 5.32.1
plenv rehash
```

then install the package manager `cpanm` with the command:

```
plenv install-cpanm
plenv rehash
```

go inside the directory for this cloned repository and install the dependecies:

```
cpanm --installdeps .
```

Now you can run the perl script with the following command:

```
perl script input.txt
```