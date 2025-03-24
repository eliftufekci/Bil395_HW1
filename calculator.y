%{
    #include <stdio.h>
    int flag=0;
    int yylex(void);
    void yyerror();
%}

%token NUMBER
%token PLUS
%token MINUS 
%token TIMES 
%token DIVIDE
%token LPAREN
%token RPAREN

%left PLUS MINUS

%left TIMES DIVIDE

%left LPAREN RPAREN

%%
ArithmeticExpression: expr{
            printf("\nresult = %d\n", $$);
            return 0;
};

expr : expr PLUS expr     { $$ = $1 + $3; }
     | expr MINUS expr    { $$ = $1 - $3; }
     | expr TIMES expr    { $$ = $1 * $3; }
     | expr DIVIDE expr   { $$ = $1 / $3; }
     | LPAREN expr RPAREN { $$ = $1; }
     | NUMBER             { $$ = $1; }
     ;

%%

void main(){
    yyparse();
}

void yyerror(){
        printf("\n Invalid expression\n");
        flag = 1;
}