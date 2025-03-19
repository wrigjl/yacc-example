
%{
#include <iostream>
#include "Expression.h"
extern int yylex(void);
extern void yyerror(const char *s);
#define YYDEBUG 1
%}

%define parse.trace

%union {
  int intval;
}

%token TokPlus
%token TokMinus
%token TokMult
%token TokDiv
%token <intval> TokNumber
%token TokNewline

%left TokPlus
%left TokMinus
%left TokMult
%left TokDiv

%type <intval> Exp

%%

Program: Program Exp TokNewline { std::cout << $2 << std::endl; }
    |
    ;

Exp: TokNumber          { $$ = $1; }
    | Exp TokPlus Exp   { $$ = $1 + $3; }
    | Exp TokMinus Exp  { $$ = $1 - $3; }
    | Exp TokMult Exp   { $$ = $1 * $3; }
    | Exp TokDiv Exp    { $$ = $1 / $3; }
    ;

%%

void yyerror(char const *s) {
    std::cerr << s << std::endl;
}

int main(void) {
    yyparse();
    return 0;
}