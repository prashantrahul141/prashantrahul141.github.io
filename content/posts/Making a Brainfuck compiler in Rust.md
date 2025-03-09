+++
title = "Making a Brainfuck compiler in Rust"
date = "2024-02-24"
word_count = false

[extra]
read_time = true

[taxonomies]
tags=["rust", "brainfuck"]
+++

# Links

brainf\*ck wikipedia: {{ external_link(url="https://en.wikipedia.org/wiki/Brainfuck" ) }}

brainf\*ck basics: {{ external_link(url="https://gist.github.com/roachhd/dce54bec8ba55fb17d3a" ) }}

source: {{ external_link(url="https://github.com/prashantrahul141/bf-interpreter-rs") }}

# So What is brainfuck?

lets look up on wikipedia

![Brainfuck on wikipedia](/posts/images/0001.png)

so basically its an programming language which works with only 8 simple commands, and here are the 8 simple commands:

![Brainfuck on wikipedia](/posts/images/0002.png)

you might be wondering how you can make something with only these 8 commands to work with

# How does the language work?

imagine a really long line of cells with values stored in the cells, initially all of the values will be zero, we will call this "memory"

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]

```

now imagine a pointer, pointing to one of the cell in the memory, initially it will point at the first cell.

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
                                  ^
```

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
 ^
```

all the operations you do using the 8 commands will be done on the memory and using this simple pointer.
you can move the pointer to one cell to right using the right angle bracket operator '>'

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
    ^
```

you can move the pointer to one cell to left using the left angle bracket operator '<'

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
 ^
```

you can increment the value in the cell, which is currently being pointed at using the plus operator '+'

```
[1][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
 ^
```

you can decrement the value in the cell, which is currently being pointed at using the minus operator '-'

```
[0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
 ^
```

you can print the value of the cell currently being pointed at in ascii text using the dot operator '.', so if the value is, lets say 83,

```
[83][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0][0]
 ^
```

if we look up the value of ascii code 83,

![ascii table](/posts/images/0003.png)

its capital 'S', so the dot '.' operator will print a capital "S".

you can read data from user using the comma "," operator, it will save the data in the cell which is currently pointed at.

and finnaly the opening and closing bracket operators \"[\" \"]\".

the opening bracket operator says, if the data at currently pointed cell is zero, then instead of continuing the execution normally, jump directly to the instruction which comes after the closing bracket operator "]"
its like a loop and if statement combined.

and thats basically it, that's all you need to make a turing complete programming language. I present to you "Hello World!" program in brainfuck.

```bf
>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.[-]
>++++++++[<++++>-] <.>+++++++++++[<++++++++>-]<-.--------.+++
.------.--------.[-]>++++++++[<++++>- ]<+.[-]++++++++++.
```

now, i would really like to talk more about the language and how people have come up with really smart ways to do different kindof things in the language, but thats beside the video in hand, but you can learn more about it here:

brainf\*ck basics: {{ external_link(url="https://gist.github.com/roachhd/dce54bec8ba55fb17d3a" ) }}

today, we're going to write an interpreter for brainfuck, and we're going to do that in Rust.

first we create a new binary project using cargo.

```sh
cargo init --bin --name bf-interpreter-rs
```

# Lexical Analysis

First we need a way to convert a long string of brainfuck operators, into series of lexical tokens.
so we create a "Lexer" structure
```rs
/// Lexer
pub struct Lexer {
    /// Vector of tokens scanned.
    pub tokens: Vec<Token>,
}
```


it will hold a vector of all the tokens it scanned.
and here's what a single token is:
```rs
/// Holds information about a token.
#[derive(Debug)]
pub struct Token {
    pub line: usize,
    pub token_type: TokenType,
}
```

it holds where the token is present in the input string, and also what type of token it is.

```rs
// All the operators which exists in brainf*ck
#[derive(Debug, PartialEq)]
pub enum TokenType {
    RightAngle,  // >
    LeftAngle,   // <
    Plus,        // +
    Minus,       // -
    RightSquare, // ]
    LeftSquare,  // [
    Comma,       // ,
    Dot,         // .
    Eof,         // end of file.
}
```

and here is a enum storing all the types of token a token can be, we also add a special EOF, or END OF FILE token which will come in handy later when we come to parsing.

```rs
/// Scans a string into Vec of Tokens.
/// # Arguments
/// * input - Immutable reference to the string to scan.
/// # Returns
/// * tokens - Vector of Tokens scanned.
fn scan_tokens(input: &str) -> Vec<Token> {
}
```

now for scanning, we create a new method on the lexer struct, "scan_tokens"
it will take a string input and return a vector of tokens it scanned.

```rs
fn scan_tokens(input: &str) -> Vec<Token> {
    let mut line = 1;
}
```

we will also need to store the line number we're at in the input string, we so create a local variable "line".


```rs
let mut tokens = input
```

and for scanning tokens, we take the input string

```rs
let mut tokens = input
    // taking characters
    .chars()
```

then take indiviual characters from the string

```rs
let mut tokens = input
    // taking characters
    .chars()
    // mapping through it
    .flat_map(|lexeme| {})
```

and map through each character, we match each character for all the operators

```rs
let mut tokens = input
    // taking characters
    .chars()
    // mapping through it
    .flat_map(| lexeme | {
        '>' => Some(Token {
            line,
            token_type: TokenType::RightAngle,
        })
    })
```

for example, if we find a right angle bracket, we create a token at current line number of type RightAngleBracket.

```rs
       // if the character is >
       '>' => Some(Token {
           line,
           token_type: TokenType::RightAngle,
       }),

       // if the character is <
       '<' => Some(Token {
           line,
           token_type: TokenType::LeftAngle,
       }),

       // if the character is +
       '+' => Some(Token {
           line,
           token_type: TokenType::Plus,
       }),

       // if the character is -
       '-' => Some(Token {
           line,
           token_type: TokenType::Minus,
       }),

       // if the character is ]
       ']' => Some(Token {
           line,
           token_type: TokenType::RightSquare,
       }),

       // if the character is [
       '[' => Some(Token {
           line,
           token_type: TokenType::LeftSquare,
       }),

       // if the character is ,
       ',' => Some(Token {
           line,
           token_type: TokenType::Comma,
       }),

       // if the character is .
       '.' => Some(Token {
           line,
           token_type: TokenType::Dot,
       }),
```


and simillary we match for <, +, -, ], [ , ",", "." and keep adding tokens at the current line number of that type,
```rs
       // if its a newline character,
       // we increase line number count.
       '\n' => {
           line += 1;
           None
       }
```
but if we see a newline character, we increment the line count and return None.

```rs
      // consider everything else as comments.
      _ => None,
```

and everything else is also ignored, as we consider them as "comments"

```rs
        // consider everything else as comments.
        _ => None,
    })
    .collect::<Vec<Token>>();
```

then we collect this flat_map into a vector of tokens

```rs
    // push a EOF token at the end.
    tokens.push(Token {
        line,
        token_type: TokenType::Eof,
    });
```

we also manually add a EOF token at the end

```rs
   // reverse tokens since we are going to pop it.
   tokens.reverse();

   tokens
}
```
finally we reverse the tokens vector, and return it

and thats the entire scanning process in one go.
```rs
    /// Removes and Returns the next Token.
    pub fn pop(&mut self) -> Token {
        self.tokens
            .pop()
            .expect("[Lexer] Failed to get next token.")
    }

    /// Returns reference to the next Token without removing it.
    pub fn peek(&self) -> &Token {
        self.tokens
            .last()
            .expect("[Lexer] Failed to peek next token.")
    }
}
```
we also add these two helpers, pop and peek which we will need later

and now if we give our lexer a simple brainfuck program like this one

```
>++.
-.
```

it gives us meaningful tokens from the string

```rs
Token { line: 1, token_type: RightAngle }
Token { line: 1, token_type: Plus }
Token { line: 1, token_type: Plus }
Token { line: 1, token_type: Dot }
Token { line: 2, token_type: Minus }
Token { line: 2, token_type: Dot }
Token { line: 2, token_type: Eof }
```

and with that we're done with the lexer.

# Parsing

Now comes "Parsing", in this process we can either create a AST or instructions from the tokens we got from the lexer. we're going to do the later.

we start by creating a new file, and a Parser structure

```rs
/// Parser - Parses stream of tokens into vector of instructions.
pub struct Parser<'a> {
    lexer: &'a mut Lexer,
    pub statements: Vec<Stmt>,
}
```

it consists of two fields, a mutable reference to the lexer, and a vector of statements.

```rs
// statements supported by the vm.
#[derive(Debug)]
pub enum Stmt {
    NodeStmt(OpCode),
    WhileStmt(Vec<Stmt>),
}
```

and a statement can be either a NodeStmt or a WhileStmt, A NodeStmt will have a operation code and a WhileStmt will have a vector of statements inside it.

```rs
// Instruction set supported by the vm.
#[derive(Debug)]
pub enum OpCode {
    // moves pointer one cell right.
    MovePtrForward,
    // moves pointer one cell left.
    MovePtrBackward,
    // reads one character from stdin.
    ReadFromStdin,
    // writes one character to stdout.
    WriteToStdout,
    // increment or decrement value at the ptr.
    Crement(i8),
}
```

the operations code we will allow are

- MovePtrForward - it moves the pointer one cell forward.
- MovePtrBackward - it moves the pointer one cell backward.
- ReadFromStdin - reads data from stdin and save it in the current cell.
- WriteToStdout - writes current cell data to the stdout.
- Crement - it stores a signed 8 bit value and increments or decrements the value of current cell with that value. I know i could have made two separate instructions for increment and decrement, but a abstracted instruction which can do both just feels right to me for some reason.

```rs
/// Public parse function which instiates the parsing process.
pub fn parse(&mut self) {
    while !self.match_token(TokenType::Eof) {
        if let Some(stmt) = self.parse_stmt() {
            self.statements.push(stmt);
        }
    }
}
```

we create a public parse function which loops through the tokens and parses statements untill it finds a EOF token.

```rs
// matches the current token with the given type.
fn match_token(&self, tt:TokenType) -> bool {
    if self.is_at_end() {
        return false;
    }

    self.lexer.peek().token_type == tt
}
```

this also uses this small helper function which just matches the current token we're parsing.

```rs
/// checks if there are no more tokens to parse
fn is_at_end(&self) -> bool {
    self.lexer.tokens.is_empty()
}
```

which internally uses this helper function, which just checks if there are not more tokens to parse.

```rs
/// parses individual instruction
fn parse_stmt(&mut self) -> Option<Stmt> {
    let current = self.lexer.pop();
}
```

now in the parse_stmt function, we take indiviual tokens, then we match it against the types of tokens possible and return the respective statements,

for simple operations like move pointer one cell to the right, just simple return a NodeStmt with the corresponding operation code.

```rs
    match current.token_type {
        // >
        TokenType::RightAngle => Some(Stmt::NodeStmt(OpCode::MovePtrForward)),
        // <
        TokenType::LeftAngle => Some(Stmt::NodeStmt(OpCode::MovePtrBackward)),
        // +
        TokenType::Plus => Some(Stmt::NodeStmt(OpCode::Crement(1))),
        // -
        TokenType::Minus => Some(Stmt::NodeStmt(OpCode::Crement(-1))),
        // ,
        TokenType::Comma => Some(Stmt::NodeStmt(OpCode::ReadFromStdin)),
        // .
        TokenType::Dot => Some(Stmt::NodeStmt(OpCode::WriteToStdout)),
        // for '[' we call the parse_instruction function recurisvely.
        TokenType::LeftSquare => {
            let mut inner_instructions: Vec<Stmt> = vec![];

            while !self.match_token(TokenType::RightSquare) {
                if let Some(instruction) = self.parse_stmt() {
                    inner_instructions.push(instruction);
                }
            }

            // consuming ']'
            self.lexer.pop();

            Some(Stmt::WhileStmt(inner_instructions))
        }
        // if we encounted a ']' without a starting ']' its a parser error.
        TokenType::RightSquare => {
            Parser::error("Unexpected ']'", &current);
            None
        }
        // shoudnt be reachable.
        TokenType::Eof => None,
    }
```

and for parsing left square bracket, we first create a empty vector of statements, we then recursively call the parse statement function and keep adding the parsed statements to the vector we created untill we reach a closing right square bracket

and since we stop the loop once we reach a closing square bracket we also need to consume that token, finnally we return the vector of parsed statement inside a WhileStmt.

and that parses opening and closing square brackets.

also for the left token types,
if we find a closing square bracket without a opening square bracket, it's parses error.
and EOF token shouldn't be reachable since we don't enter the parse_stmt function if we encounter one.

now if we give our input to lexer and then to parser,

```
+-<>,.
```

we get something like this

```rs
NodeStmt(Crement(1))
NodeStmt(Crement(-1))
NodeStmt(MovePtrBackward)
NodeStmt(MovePtrForward)
NodeStmt(ReadFromStdin)
NodeStmt(WriteToStdout)
```

and with that, our parser is complete.

# VM

We are now at the final stage of our interpreter, a Virtual Machine,
Our Virtual Machine or VM for short, has 1 job, run through the instructions, and execute them.

```rs
// Our virtual machine which will execute instructions.
pub struct Vm<'a> {
    statements: &'a Vec<Stmt>,
    pointer: usize,
    data: [u8; 30000],
}
```

for the final time, we start by creating a structure, VM, it will hold a reference to
statements it needs to execute, data pointer, and u8 array of size thirty thousands.

```rs
/// public run method to start execution
pub fn run(&mut self) {
    for statement in self.statements {
        self.run_stmt(statement);
    }
}
```
we implement a public "run" method, which iterates through each statement and call run_statement method on them.

```rs
// runs individual statement
fn run_stmt(&mut self, stmt: &Stmt) {
    match stmt {
        Stmt::NodeStmt(op_code) => self.run_opcode(op_code),
        Stmt::WhileStmt(stmts) => self.while_stmt(stmts),
    }
}
```

and here's the run_stmt method, it matches the type of statement and calls run_opcode if its a simple NodeStmt

the run_opcode method literally just matches the operation code which
gets passed to it and directly executes, for example if the operation
code is MovePtrForward, it just increments the data pointer, and for ReadFromStdin operation code, it reads from the standard input and stores them in the current cell.

```rs
fn run_opcode(&mut self, node: &OpCode) {
    match node {
        // moves pointer forward.
        OpCode::MovePtrForward => self.pointer += 1,

        // moves pointer backward.
        OpCode::MovePtrBackward => self.pointer -= 1,

        // reads input from stdin and writes to current pointed cell.
        OpCode::ReadFromStdin => {
            let mut input = String::new();
            std::io::stdin().read_line(&mut input).unwrap_or(0);
            let first_char = input.as_bytes().first().copied().unwrap_or(0);
            self.data[self.pointer] = first_char;
        }

        // writes current cell as char to stdout.
        OpCode::WriteToStdout => {
            print!(
                "{}",
                std::char::from_u32(self.data[self.pointer] as u32).unwrap_or('0')
            )
        }

        // increments or decrements current pointed value.
        OpCode::Crement(value) => {
            self.data[self.pointer] = (self.data[self.pointer] as i8 + value) as u8;
        }
    }
}
```

if the statement we are parsing is a whileStmt, we call while_stmt method, this loops through the instruction inside the node vector and executes them as long as the data in the currently pointed cell is not zero.

```rs
// while statements
fn while_stmt(&mut self, node: &Vec<Stmt>) {
    while self.data[self.pointer] != 0 {
        for stmt in node {
            self.run_stmt(stmt);
        }
    }
}
```

and with that our VM is ready.

# Connecting everything into a beautiful pipeline.

we can now create a simple top level run function, which read input from a file, and connect our lexer, our parse and finnaly our VM.

simple enough, here it is:
```rs
// start the interpreter.
pub fn run(&self) {
    // if != 2 number of arguments are passed.
    if env::args().len() != 2 {
        println!("bfir - Brainf*ck Interpreter in Rust.\n\nUsage:\n    bfirs [filename]");
        exit(0);
    };

    // read file content.
    let file_content = App::get_file_contents(&env::args().collect::<Vec<String>>()[1]);

    // create a new lexer, and tokenize file string.
    let mut lexer = Lexer::new(&file_content);

    // create a new parser
    let mut parser = Parser::new(&mut lexer);
    // parse the tokens to stmts
    parser.parse();

    // creates a new vm
    let mut vm = Vm::new(&parser.statements);
    // run statements.
    vm.run();
}
```
it also uses this simple helper function to read data from the file.

```rs
// reads file content, returns string of file content otherwise panics.
fn get_file_contents(filepath: &str) -> String {
    let contents = fs::read_to_string(filepath);

    if let Ok(file) = contents {
        return file;
    }

    panic!("Failed to open file.")
}
```

and with that our whole intepreter is ready. so lets test it.

here's the hello world program from earlier,

```bf
>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.[-]
>++++++++[<++++>-] <.>+++++++++++[<++++++++>-]<-.--------.+++
.------.--------.[-]>++++++++[<++++>- ]<+.[-]++++++++++.
```

lets give that to our interpreter,

![results](/posts/images/0004.png)

we can see it working as we expected.

I have cleaned up the code a little,and pushed it to github: {{ external_link(url="https://github.com/prashantrahul141/bf-interpreter-rs") }}

and there are some examples in the ./examples directory for you to test the interpreter.

and thank you for reading!
