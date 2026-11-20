# latex-math-template

Here is the structure:
You would have one file for each of the rootfiles you're working on under /rootfiles e.g. notes.tex excercises.tex etc. You would compile each separetly and have a pdf for each one. Also with a separate tex output dir for the logs.

## compile
To compile one of this rootfiles you would run e.g:

```bash
CLEAN=1 ./compile.sh rootfiles/single-excersice.tex x04.pdf
```
Output pdf would be under /output

## rootfiles
This is for when you want to compile multiples files under the same repo. You could also create e.g. /main.tex if the project has a biger purpose.

For each of this project you would have a folder under src/<projecz/topic> to keep them separated.

Under files you would save static data like images and pdf that would be included in the tex file.