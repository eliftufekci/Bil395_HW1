%{
    #include <stdio.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%

[ \t]; // boşluk yada tab gelirse görmezden gel

[0-9]+ {
            yylval = atoi(yytext);
            return NUMBER; // number token i döner
       }

\+  { return PLUS;   }
\-  { return MINUS;  }
\*  { return TIMES;  }
\/  { return DIVIDE; }      
\(  { return LPAREN; } 
\)  { return RPAREN; }


[\n] return 0; // enter karakteri gelirse de işlemi bitirsin

. return yytext[0];

%%

int yywrap(){
    return 1;
}