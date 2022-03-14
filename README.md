# Program 3

## Objectives
1. Implementing data validation
2. Implementing an accumulator
3. Integer arithmetic
4. Defining variables (integer and string)
5. Using library procedures for I/O
6. Implementing control structures (decision, loop)

## Problem Definition
Write a MASM program to perform the following tasks:
- Display the program title and programmer’s name.
- Get the user's name, and greet the user.
- Display instructions for the user
- Repeatedly prompt the user to enter the number. Validate the user input to be in [-100, -1] (inclusive). Count and accumulate the valid user numbers until a non-negative number is entered (The non-negative number is discarded)
- Calculate the (rounded integer) average of the negative numbers
- Display:
  - the number of negative numbers entered (Note: if no negative numbers were entered, display a special message and display the goodbye message with the user's name at the end)
  - the sum of negative numbers entered
  - the average, rounded to the nearest integer (e.g., -20.5 rounds to -21)
  - a goodbye message that includes the user’s name, and terminate the program.


## Requirements
1. The programmer’s name and the user’s name must appear in the output.
2. The main procedure must be modularized into commented logical sections (procedures are not required this time).
3. Recursive solutions are not acceptable for this assignment. This one is about iteration.
4. The program must be fully documented. This includes a complete header block for identification, description, etc., and a comment outline to explain each section of code.
5. The lower limit must be defined and used as a constant.
6. The usual requirements regarding documentation, readability, user-friendliness, etc., apply.

## Notes
1. There are no new concepts in this programming assignment. It is given for extra practice, to keep MASM fresh in your mind while we study internal/external data representation and error detection/correction.
2. This is an integer program. Even though it would make more sense to use floating-point computations, you are required to do this one with integers.

Example Program Operation

```
Welcome to the Integer Accumulator by Austin Miller
What’s your name? Roger
Hello, Roger

Please enter numbers in [-100, -1].
Enter a non-negative number when you are finished to see results.
Enter number: -15
Enter number: -100
Enter number: -36
Enter number: -200
Invalid number, please enter numbers in [-100, -1].
Enter number: -10
Enter number: 0
You entered 4 valid numbers. 
The sum of your valid numbers is -161
The rounded average is -40
Thank you for playing Integer Accumulator!
Goodbye, Roger.
```

## Extra Credit Option (original definition must be fulfilled)
- (1 pt) Calculate and display the average as a floating-point number, rounded to the nearest .001.

Remember, in order to ensure you receive credit for any extra credit work, you must add one print statement to your program output PER EXTRA CREDIT which describes the extra credit you chose to work on. You will not receive extra credit points unless you do this. The statement must be formatted as follows...

```
--Program Intro--
**EC: DESCRIPTION
--Program prompts, etc--
```

Please refer back to the documentation for Program 1 to see a sample of the extra credit format.
