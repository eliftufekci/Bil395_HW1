%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
%}

integer  [0-9]+
reel   ([0-9]*\.[0-9]+)

%%

{integer} { yylval.integer = atoi(yytext);
            return INTEGER; }

{reel}    { yylval.reel = atof(yytext); 
            return DOUBLE; }
\^  { return EXPO;   }
\+  { return PLUS;   }
\-  { return MINUS;  }
\*  { return TIMES;  }
\/  { return DIVIDE; }      
\(  { return LPAREN; } 
\)  { return RPAREN; }

[\t ] ; // boşluk yada tab gelirse görmezden gel

[\n] return 0; // enter karakteri gelirse de işlemi bitirsin

. return yytext[0];

%%

int yywrap(){
    return 1;
}