#ifndef _CMATHPARSER_H_
#define _CMATHPARSER_H_
//{{{ Includes 
#include <stdlib.h>
#include <math.h>
//}}}
//{{{ Structures 
typedef struct Token {
	double data;
	unsigned int type;
	unsigned int precedence;
	struct Token* next;
} token;
typedef token* token_t;

typedef struct ExprTreeNode {
	double data;
	unsigned int type;
	struct ExprTreeNode* left;
	struct ExprTreeNode* right;
} expr_tree_node;
typedef expr_tree_node* expr_tree_t;

typedef struct ExprTreeStack {
	expr_tree_t ptr;
	struct ExprTreeStack* next;
} expr_tree_stack;
typedef expr_tree_stack* expr_tree_stack_t;
enum { DOUBLE, PLUS, MINUS, MULTIPLICATION, DIVISION, MODULUS, POWER, LPAREN, RPAREN, SIN, COS, TAN, CSC, SEC, COT, ASIN, ACOS, ATAN, MIN, MAX };
//}}}
//{{{ Functions 
//{{{ token_t tokenize(const char*) 
token_t tokenize(const char* exp){
	token_t head = (token_t)malloc(sizeof(token));
	token_t curr = NULL;
	head->data = 0.0;
	head->next = NULL;
	curr = head;

	char c;
	char p = 0;
	int len = 0;
	while (1){
		if (exp[len] == '\0'){
			break;
		}
		len++;
	}
	int i = 0;
	double decimalModifier;
	int afterDecimal = 0;
	int needsToTurnNegative = 0;

	while (i < len){
		c = exp[i++];
		
		if (c == ' '){
			continue;
		} else if (c > 47 && c < 58){ // c is a digit

			curr->type = DOUBLE;

			if (afterDecimal){
				curr->data += ((c - '0') * decimalModifier);
				decimalModifier /= 10;
			} else {
				curr->data *= 10;
				curr->data += (c - '0');
			}

			if (needsToTurnNegative){
				curr->data *= -1;
				needsToTurnNegative = 0;
			}

		} else if (c > 96 && c < 123){ // c is a letter

			if (p > 47 && p < 58){
				afterDecimal = 0;
				if (i < len){
					curr->next = (token_t)malloc(sizeof(token));
					curr = curr->next;
					curr->data = 0.0;
					curr->next = NULL;
				}
			}

			int found1 = 0;
			int found2 = 0;
			if (i + 3 < len){
				if (exp[i - 1] == 'a' && exp[i] == 's' && exp[i + 1] == 'i' && exp[i + 2] == 'n'){ // asin()
					curr->type = ASIN;
					curr->precedence = 5;
					found1 = 1;
				} else if (exp[i - 1] == 'a' && exp[i] == 'c' && exp[i + 1] == 'o' && exp[i + 2] == 's'){ // acos()
					curr->type = ACOS;
					curr->precedence = 5;
					found1 = 1;
				} else if (exp[i - 1] == 'a' && exp[i] == 't' && exp[i + 1] == 'a' && exp[i + 2] == 'n'){ // atan()
					curr->type = ATAN;
					curr->precedence = 5;
					found1 = 1;
				}
			}
			if (found1 == 0){
				if (i + 2 < len){
					if (exp[i - 1] == 's' && exp[i] == 'i' && exp[i + 1] == 'n'){ // sin()
						curr->type = SIN;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 'c' && exp[i] == 'o' && exp[i + 1] == 's'){ // cos()
						curr->type = COS;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 't' && exp[i] == 'a' && exp[i + 1] == 'n'){ // tan()
						curr->type = TAN;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 'c' && exp[i] == 's' && exp[i + 1] == 'c'){ // csc()
						curr->type = CSC;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 's' && exp[i] == 'e' && exp[i + 1] == 'c'){ // sec()
						curr->type = SEC;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 'c' && exp[i] == 'o' && exp[i + 1] == 't'){ // cot()
						curr->type = COT;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 'm' && exp[i] == 'i' && exp[i + 1] == 'n'){ // cot()
						curr->type = MIN;
						curr->precedence = 5;
						found2 = 1;
					} else if (exp[i - 1] == 'm' && exp[i] == 'a' && exp[i + 1] == 'x'){ // cot()
						curr->type = MAX;
						curr->precedence = 5;
						found2 = 1;
					}
				}
			}

			if (found1){
				i += 3;
				if (i < len){
					curr->next = (token_t)malloc(sizeof(token));
					curr = curr->next;
					curr->data = 0.0;
					curr->next = NULL;
				}
			} else if (found2){
				i += 2;
				if (i < len){
					curr->next = (token_t)malloc(sizeof(token));
					curr = curr->next;
					curr->data = 0.0;
					curr->next = NULL;
				}
			} else { // c is a variable identifier

			}

		} else { // c is a symbol
			
			if (c == '-'){

				if (!(p > 47 && p < 58) || p == '(' || p == 0){
					needsToTurnNegative = 1;
				} else {
					if (p > 47 && p < 58){
						afterDecimal = 0;
						if (i - 1 < len){
							curr->next = (token_t)malloc(sizeof(token));
							curr = curr->next;
							curr->data = 0.0;
							curr->next = NULL;
						}
					}
					curr->precedence = 2;
					curr->type = MINUS;		
					if (i < len){
						curr->next = (token_t)malloc(sizeof(token));
						curr = curr->next;
						curr->data = 0.0;
						curr->next = NULL;
					}
				}

			} else if (c == ','){
			
				if (p > 47 && p < 58){
					afterDecimal = 0;
					if (i - 1 < len){
						curr->next = (token_t)malloc(sizeof(token));
						curr = curr->next;
						curr->data = 0.0;
						curr->next = NULL;
					}
				}

			} else if (c != '.'){

				if (p > 47 && p < 58){
					afterDecimal = 0;
					if (i - 1 < len){
						curr->next = (token_t)malloc(sizeof(token));
						curr = curr->next;
						curr->data = 0.0;
						curr->next = NULL;
					}
				}

				switch (c){
					case '+': curr->precedence = 2; curr->type = PLUS; break;
					case '*': curr->precedence = 3; curr->type = MULTIPLICATION; break;
					case '/': curr->precedence = 3; curr->type = DIVISION; break;
					case '%': curr->precedence = 3; curr->type = MODULUS; break;
					case '^': curr->precedence = 4; curr->type = POWER; break;
					case '(': curr->precedence = 5; curr->type = LPAREN; break;
					case ')': curr->precedence = 5; curr->type = RPAREN; break;
				}

				if (i < len){
					curr->next = (token_t)malloc(sizeof(token));
					curr = curr->next;
					curr->data = 0.0;
					curr->next = NULL;
				}

			} else { // if c == '.'
				afterDecimal = 1;
				decimalModifier = 0.1;
			}
				
		}

		p = c;
	}

	if (curr->data != 0.0){
		curr->type = DOUBLE;
	}

	return head;
}
//}}}
//{{{ token_t infix_to_postfix(token_t) 
token_t infix_to_postfix(token_t tokens){
	token_t opstack = NULL;
	token_t rpn = NULL;
	token_t rpn_curr = NULL;
	token_t curr = tokens;

	while (curr != NULL){
		
		if (curr->type == DOUBLE){

			if (rpn_curr == NULL){
				rpn_curr = (token_t)malloc(sizeof(token));
				rpn = rpn_curr;
			} else {
				rpn_curr->next = (token_t)malloc(sizeof(token));
				rpn_curr = rpn_curr->next;
			}

			rpn_curr->data = curr->data;
			rpn_curr->type = curr->type;
			rpn_curr->next = NULL;

		} else {
			
			if (curr->type == LPAREN){
				token_t tmp = (token_t)malloc(sizeof(token));
				tmp->type = curr->type;
				tmp->precedence = curr->precedence;
				tmp->next = opstack;
				opstack = tmp;
			} else if (curr->type == RPAREN){
				while (opstack->type != LPAREN){
					token_t tmp = (token_t)malloc(sizeof(token));
					tmp = opstack;
					opstack = opstack->next;

					rpn_curr->next = (token_t)malloc(sizeof(token));
					rpn_curr = rpn_curr->next;
					rpn_curr->type = tmp->type;
					rpn_curr->precedence = tmp->precedence;
					rpn_curr->next = NULL;

					free(tmp);
				}

				token_t tmp = (token_t)malloc(sizeof(token));
				tmp = opstack;
				opstack = opstack->next;
				free(tmp);
			} else {
				if (opstack != NULL && !(opstack->type == POWER && curr->type == POWER)){
					while (opstack != NULL && opstack->type != LPAREN && opstack->precedence >= curr->precedence){
						token_t tmp = (token_t)malloc(sizeof(token));
						tmp = opstack;
						opstack = opstack->next;

						rpn_curr->next = (token_t)malloc(sizeof(token));
						rpn_curr = rpn_curr->next;
						rpn_curr->type = tmp->type;
						rpn_curr->precedence = tmp->precedence;
						rpn_curr->next = NULL;

						free(tmp);
					}
				}

				token_t tmp = (token_t)malloc(sizeof(token));
				tmp->type = curr->type;
				tmp->precedence = curr->precedence;
				tmp->next = opstack;
				opstack = tmp;
			}
		}

		curr = curr->next;
	}

	while (opstack != NULL){
		token_t tmp = (token_t)malloc(sizeof(token));
		tmp = opstack;
		opstack = opstack->next;

		rpn_curr->next = (token_t)malloc(sizeof(token));
		rpn_curr = rpn_curr->next;
		rpn_curr->type = tmp->type;
		rpn_curr->precedence = tmp->precedence;
		rpn_curr->next = NULL;

		free(tmp);
	}

	return rpn;
}
//}}}
//{{{ expr_tree_t generate_expression_tree(token_t) 
expr_tree_t generate_expression_tree(token_t tokens){
	expr_tree_stack_t head = NULL;
	expr_tree_stack_t ets_curr = NULL;
	token_t curr = tokens;
	
	while (curr != NULL){
		
		if (curr->type == DOUBLE){
			
			if (ets_curr == NULL){
				ets_curr = (expr_tree_stack_t)malloc(sizeof(expr_tree_stack));
				head = ets_curr;
			} else {
				ets_curr = head;
				while (ets_curr->next != NULL) ets_curr = ets_curr->next;
				ets_curr->next = (expr_tree_stack_t)malloc(sizeof(expr_tree_stack));
				ets_curr = ets_curr->next;
			}
			ets_curr->ptr = (expr_tree_t)malloc(sizeof(expr_tree_node));
			ets_curr->ptr->data = curr->data;
			ets_curr->ptr->type = curr->type;
			ets_curr->ptr->left = NULL;
			ets_curr->ptr->right = NULL;
			ets_curr->next = NULL;

		} else {

			expr_tree_t temp = (expr_tree_t)malloc(sizeof(expr_tree_node));
			temp->type = curr->type;
			temp->left = NULL;
			temp->right = NULL;
			
			switch (curr->type){
				case SIN:
				case COS:
				case TAN:
				case CSC:
				case SEC: // UNARY OPERATORS
				case COT:
				case ASIN:
				case ACOS:
				case ATAN:

					ets_curr = head;

					while(ets_curr->next != NULL){
						ets_curr = ets_curr->next;
					}

					temp->left = ets_curr->ptr;
					temp->right = NULL;
					ets_curr->ptr = temp;

					break;

				case PLUS:
				case MINUS:
				case MULTIPLICATION:
				case DIVISION:
				case MODULUS: // BINARY OPERATORS
				case MIN:
				case MAX:

					ets_curr = head;

					while(ets_curr->next->next != NULL){
						ets_curr = ets_curr->next;
					}

					temp->left = ets_curr->ptr;
					temp->right = ets_curr->next->ptr;
					ets_curr->ptr = temp;

					ets_curr->next = NULL;
					/*free(ets_curr);*/

					break;
				case POWER:
					
					ets_curr = head;
					token_t temp_token = curr;
					int amount = 0;

					while (temp_token->next != NULL && temp_token->next->type == POWER){
						temp_token = temp_token->next;
						amount++;
					}

					while(1){
						expr_tree_stack_t counter = ets_curr;

						for (int i = 0; i < amount; i++){
							counter = counter->next;
						}

						if (counter->next->next == NULL){
							break;
						}

						ets_curr = ets_curr->next;
					}

					temp->left = ets_curr->ptr;
					temp->right = ets_curr->next->ptr;
					ets_curr->ptr = temp;

					ets_curr->next = ets_curr->next->next;

					break;
			}

		}

		curr = curr->next;

	}

	return head->ptr;
}
//}}}
//{{{ double min(double, double) 
double min(double x, double y){
	return x > y ? y : x;
}
//}}}
//{{{ double max(double, double) 
double max(double x, double y){
	return x > y ? x : y;
}
//}}}
//{{{ double calculate(expr_tree_t) 
double calculate(expr_tree_t exp_tree){
	switch (exp_tree->type){
		case DOUBLE: return exp_tree->data; break;
		case PLUS: return (calculate(exp_tree->left) + calculate(exp_tree->right)); break;
		case MINUS: return (calculate(exp_tree->left) - calculate(exp_tree->right)); break;
		case MULTIPLICATION: return (calculate(exp_tree->left) * calculate(exp_tree->right)); break;
		case DIVISION: return (calculate(exp_tree->left) / calculate(exp_tree->right)); break;
		case MODULUS: return fmod(calculate(exp_tree->left), calculate(exp_tree->right)); break;
		case POWER: return pow(calculate(exp_tree->left), calculate(exp_tree->right)); break;
		case SIN: return sin(calculate(exp_tree->left)); break;
		case COS: return cos(calculate(exp_tree->left)); break;
		case TAN: return tan(calculate(exp_tree->left)); break;
		case CSC: return (1 / sin(calculate(exp_tree->left))); break;
		case SEC: return (1 / cos(calculate(exp_tree->left))); break;
		case COT: return (1 / tan(calculate(exp_tree->left))); break;
		case ASIN: return asin(calculate(exp_tree->left)); break;
		case ACOS: return acos(calculate(exp_tree->left)); break;
		case ATAN: return atan(calculate(exp_tree->left)); break;
		case MIN: return min(calculate(exp_tree->left), calculate(exp_tree->right)); break;
		case MAX: return max(calculate(exp_tree->left), calculate(exp_tree->right)); break;
		default: exit(1);
	}
}
//}}}
//{{{ void free_token(token_t) 
void free_token(token_t token){
	if (token == NULL) return;
	free_token(token->next);
	free(token);
}
//}}}
//{{{ void free_tree(expr_tree_t) 
void free_tree(expr_tree_t tree){
	if (tree == NULL) return;
	free_tree(tree->left);
	free_tree(tree->right);
	free(tree);
}
//}}}
//{{{ double evaluate(const char*) 
double evaluate(const char* exp){
	token_t tokens = tokenize(exp);
	token_t postfix = infix_to_postfix(tokens);
	expr_tree_t expr_tree = generate_expression_tree(postfix);
	double answer = calculate(expr_tree);

	free_token(tokens);
	free_token(postfix);
	free_tree(expr_tree);

	return answer;
}
//}}}
//}}}
#endif
