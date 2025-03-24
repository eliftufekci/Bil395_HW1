%{
    #include <stdio.h>
    #include <stdlib.h>
    int flag=0;
    int yylex(void);
    void yyerror();
%}

%union {
    int integer;
    double reel;
}

%token <reel> DOUBLE
%token <integer> INTEGER
%token PLUS
%token MINUS 
%token TIMES 
%token DIVIDE
%token EXPO
%token LPAREN
%token RPAREN

%type  <integer> int_expr
%type  <reel> double_expr
%type  <reel> D_ArithmeticExpression
%type  <integer> I_ArithmeticExpression
%type <reel> Expression

%left PLUS MINUS
%left TIMES DIVIDE
%right EXPO // kuvvet alma işlemi sağdan öncelikli
%left LPAREN RPAREN

%%
Expression: I_ArithmeticExpression {$$=$1;} | D_ArithmeticExpression {$$=$1;}


I_ArithmeticExpression: int_expr{
            if(flag == 0){
                printf("\nresult = %d\n", $$);
            }
            return 0;
};

int_expr : int_expr PLUS int_expr { $$ = $1 + $3; }
     | int_expr MINUS int_expr    { $$ = $1 - $3; }
     | int_expr TIMES int_expr    { $$ = $1 * $3; }
     | int_expr DIVIDE int_expr   { if($3 != 0) $$ = $1 / $3; else  yyerror(); }
     | int_expr EXPO int_expr     { int temp = $1; int result = 1; for (int i = 0; i < $3; i++) result *= temp; $$ = result; }
     | LPAREN int_expr RPAREN         { $$ = $2; }
     | INTEGER                    { $$ = $1; }
     ;

D_ArithmeticExpression: double_expr{
            if(flag == 0){
                printf("\nresult = %lf\n", $$);
            }
            return 0;
};

double_expr : double_expr PLUS double_expr { $$ = $1 + $3; }
     | double_expr MINUS double_expr    { $$ = $1 - $3; }
     | double_expr TIMES double_expr    { $$ = $1 * $3; }
     | double_expr DIVIDE double_expr   { if($3 != 0) $$ = $1 / $3; else  yyerror(); }
     | double_expr EXPO double_expr     { double temp = $1; double result = 1; for (int i = 0; i < $3; i++) result *= temp; $$ = result; }
     | LPAREN double_expr RPAREN        { $$ = $2; }
     | DOUBLE                           { $$ = $1; }
     ;


%%

void main(){
    yyparse();
}

void yyerror(){
        printf("\n Invalid expression\n");
        flag = 1;
}