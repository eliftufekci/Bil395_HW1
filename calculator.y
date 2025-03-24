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
            if(flag == 0){
                printf("\nresult = %d\n", $$);
            }
            return 0;
};

expr : expr PLUS expr     { $$ = $1 + $3; }
     | expr MINUS expr    { $$ = $1 - $3; }
     | expr TIMES expr    { $$ = $1 * $3; }
     | expr DIVIDE expr   { 
                            if($3 != 0) $$ = $1 / $3;
                            else  yyerror(); 
                          }
     | LPAREN expr RPAREN { $$ = $2; }
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