%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	int data[35];
%}

/* bison declarations */

%token NUM VAR IF ELSE MAIN INT FLOAT CHAR BGN END SWITCH CASE DEFAULT BREAK FOR PRINT SIN COS TAN PLUS MINUS CROSS DIVIDE MOD POW LESS GREATER TO
%nonassoc IF
%nonassoc ELSE
%nonassoc SWITCH
%nonassoc CASE
%nonassoc DEFAULT
%left '<' '>'
%left '+' '-'
%left '*' '/'

/* Grammar rules and actions follow.  */

%%

program: MAIN BGN code END
	 ;

code: /* NULL */

	| code statement
	;

statement: ';'			
	| declare ';'		
	{ 
		printf("Variable Declaration\n"); 
	}

	| expression ';' 			
	{   
		printf("Value of expression: %d\n", $1); $$=$1;
	}
	
	| VAR '=' expression ';' 
	{ 
		data[$1] = $3; 
		printf("Value of the variable: %d\t\n",$3);
		$$=$3;
	} 
	
	| PRINT '(' expression ')' ';' {printf("Print Expression %d\n",$3);}
	
	| IF '(' expression ')' BGN expression ';' END %prec IF 
	{
		if($3){
			printf("\nValue of expression in IF: %d\n",$6);
		}
		else{
			printf("Condition false in IF block\n");
		}
	}

	| IF '(' expression ')' BGN expression ';' END ELSE BGN expression ';' END 
	{
		if($3){
			printf("Value of expression in IF: %d\n",$6);
		}
		else{
			printf("Value of expression in ELSE: %d\n",$11);
		}
	}
   
	| SWITCH '(' VAR ')' BGN B  END
   
	| FOR '(' NUM TO NUM ')' BGN statement END 
	{
	    int i;
	    for(i=$3 ; i<$5 ; i++) 
		{
			printf("Value of the loop: %d expression value: %d\n", i,$8);
		}									
	}
	;
	
B   : C
	| C D
    ;
C   : C '+' C
	| CASE NUM ':' expression ';' BREAK ';' {}
	;
D   : DEFAULT ':' expression ';' BREAK ';' {}
	
declare : TYPE ID   
          ;


TYPE : INT   
     | FLOAT  
     | CHAR   
     ;



ID : ID ',' VAR  
    |VAR  
    ;

expression: NUM					{ $$ = $1; 	}

	| VAR						{ $$ = data[$1]; }
	
	| expression PLUS expression	{ $$ = $1 + $3; printf("value = %d\n",$1+$3); }

	| expression MINUS expression	{ $$ = $1 - $3; printf("value = %d\n",$1-$3);}

	| expression CROSS expression	{ $$ = $1 * $3; printf("value = %d\n",$1*$3);}

	| expression DIVIDE expression	
	{	if($3){
			$$ = $1 / $3;
			printf("value = %d\n",$1/$3);
		}
		else{
			$$ = 0;
			printf("\nDivision by zero\t");
		} 	
	}
	| expression MOD expression	
	{	if($3){
			$$ = $1 % $3;
			printf("value = %d\n",$1%$3);
		}
		else{
			$$ = 0;
			printf("\nMOD by zero\t");
		} 	
	}
	| expression POW expression	{ $$ = pow($1 , $3);}
	
	| expression LESS expression	{ $$ = $1 < $3; }
	
	| expression GREATER expression	{ $$ = $1 > $3; }

	| '(' expression ')'		{ $$ = $2;	}
	
	| SIN expression 			{printf("Value of Sin(%d) is %lf\n",$2,sin($2*3.1416/180)); $$=sin($2*3.1416/180);}

    | COS expression 			{printf("Value of Cos(%d) is %lf\n",$2,cos($2*3.1416/180)); $$=cos($2*3.1416/180);}

    | TAN expression 			{printf("Value of Tan(%d) is %lf\n",$2,tan($2*3.1416/180)); $$=tan($2*3.1416/180);}
	;
%%


yyerror(char *s){
	printf( "%s\n", s);
}

