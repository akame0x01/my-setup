### Notes bout LazyVim and Bash language 

### LazyVim
    - `$l` -  means leader key(space).
    - `$l + v` - using keys that move lines will select a line. 
    - `Esc + :e <file>` - will open a new buffer. 
    - `$l + b + b` - to switch between buffers.
    - `$l + e` - open file tree, if you choose a file, a buffer will be created.
    - `$l + =` - with a selected text, it will fix the indentation.

    - `f + <char> ` - in select mode will select to next <char> 
### Bash Language
    - `if [ -f <file> ];` - check if the file exists and if it's a regular file(i.e is not a directory instead).
    - `[ ]` - are actually a command in Unix-like systems, often used for performing various tests.
    - `local VarName` - inside a function probaly means that the first argument passed to this function will be defined to this variable.
    - `&>` - redirect both(standart output and stderr output) to a somewhere, like /dev/null and it will surpress any error log in terminal.
    - `:-` - is used to set a default value(i.e `${1:-yay}`: This is a parameter expansion or substitution that retrieves the value of the first command-line argument ($1). The :- syntax is used to provide a default value if the variable is unset or null. In this case, if $1 is unset or null, it defaults to "yay".)
    - ` -z ` - checks if a variable is NULL or zero length.


