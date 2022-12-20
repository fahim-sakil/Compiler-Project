%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#include "project.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]
header					"import"[ ]*+[^\n]+[.h][ ]*
singleLineComment		[ ]*[$][$][a-zA-Z0-9@$%^&*(){}_+-,.:\|?>< ]*
multipleLineComment		[ ]*[$][/][a-zA-Z0-9@$*(){}_+-,.:\|?><\n\t ]*[/][$]	

%%

{digit}+	{ yylval = atoi(yytext); return NUM; }
{alpha}	    { yylval = *yytext - 'a'; return	VAR; }

{header}  				{}
"start"	   { return MAIN; }

"[" 		   { return BGN;  }
"]"  		   { return END;	}

"intgr"  			 {return INT;}
"char" 		         {return CHAR;}
"flt" 			 	{return FLOAT;}

"plus"		   { return PLUS;   }	
"minus"		   { return MINUS;  }
"cross"		   { return CROSS;  }
"divide"       { return DIVIDE; }
"mod"          { return MOD;    }
"pow"		   { return POW;    }

"less"		   { return LESS;   }
"greater"	   { return GREATER;}

"out" 		       { return PRINT; }

"when" 		   { return IF;   }
"otherwise" 	   { return ELSE; }

"switching" 		   { return SWITCH; }
"case"   		   { return CASE;  } 
"exit"  		   { return BREAK;  }
"def" 	   { return DEFAULT; }


"lp_for" 		   { return FOR;}

"SIN"			   {return SIN;}
"COS"            {return COS;}
"TAN"            {return TAN;}
"to"			{return TO;}

{singleLineComment}		{printf("This is a single line comment\n");}
{multipleLineComment}	{printf("This is a multiple line comment\n");}

[-+/*<>=,():;%^]     {yylval = yytext[0];	return *yytext;	}


[ ]*	    			{}
[\n]*					{}
[\t]*					{}
.						{printf("%s --> invalid\n",yytext);}


%%
int yywrap()
{
	return 1;
}

int main()
{
	freopen("in.txt","r",stdin);
	freopen("out.txt","w",stdout);
	yyparse();
    
	return 0;
}