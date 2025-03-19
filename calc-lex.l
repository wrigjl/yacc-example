
%{
#include <string>
#include <vector>
#include <list>
#include "Expression.h"
#include "calc-parser.h"
%}

%option noyywrap
%option nounistd
%option never-interactive

%%

"+"                     return TokPlus;
"-"                     return TokMinus;
"*"                     return TokMult;
"/"                     return TokDiv;

[ \t]+                  { /* ignore */ }
\n                      {
                            yylineno++;
                            return TokNewline;
                        }

[0-9]+                  {
                            yylval.intval = atoi(yytext);
                            return TokNumber;
                        }

<<EOF>>                 return 0;

%%
