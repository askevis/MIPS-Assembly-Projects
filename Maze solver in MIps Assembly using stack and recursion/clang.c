#include <stdio.h>
#include <stdlib.h>

int ZERO = 0, v0, v1, a0, a1, a2, a3, a4, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, s0, s1, s2, s3, s4, s5, s6, s7, ra;
int W = 21;
int H = 11;
int startX = 1;
int TotalElements = 231;

char temp[100];
int indextemp[232];
int rastore[232];
int returns[232];
char map[232] = "I.IIIIIIIIIIIIIIIIIII"
                "I....I....I.......I.I"
                "III.IIIII.I.I.III.I.I"
                "I.I.....I..I..I.....I"
                "I.I.III.II...II.I.III"
                "I...I...III.I...I...I"
                "IIIII.IIIII.III.III.I"
                "I.............I.I...I"
                "IIIIIIIIIIIIIII.I.III"
                "@...............I..II"
                "IIIIIIIIIIIIIIIIIIIII";

 int main()
 {
	s0 = W;
	s1 = H;
	s3 = startX;
	s4 = TotalElements;
	s7 = 1;
    printLabyrinth();
	s5 = s3; // COUNTER FOR makeMove
	indextemp[s5] = s3;
    makeMove();
    printf("\nThe best solution for this maze is :\n");
    printLabyrinth();
    return 0;
}

void printLabyrinth(void)
{
    int i, j, k = 0;
    t9 =0;
    t5 = 0;
    t8 = 0;
    usleep(200000);
    printf("Labyrinth:\n");
    t9 = 0;
    before_first_loop:
    if(t9 >= s1) goto print_end;
        t5 = 0;
        before_s_loop:
        if(t5 >= s0) goto after_s_loop;
			t7 = temp[t5];
			t4 = 0;
			t6 = 0;
            temp[t5] = map[t8];
            t8 = t8 + 1;
            t5 = t5 + 1;
            goto before_s_loop;
        after_s_loop:
        t5 = t5 + 1;
        t7 = 4;
        temp[t5] = (char)t7;
        printf("%s\n", temp);
        t9 = t9 + 1;
        goto before_first_loop;
    print_end:
        return;
}

int makeMove(void)
{
	t1 = indextemp[s5];
	s5 = t1;
	if(t1 >= 0) goto case_dot;
		returns[s5] = ZERO;
		t8 = s5 - 1;
		ra = rastore[t8];
		return ra;
		if(t1 < s4) goto case_dot;
		returns[s5] = ZERO;
		t8 = s5 - 1;
		ra = rastore[t8];
		return ra;
	case_dot:
		t2 = 46;
		t3 = (int)map[t1];
		if(t3 != t2) goto case_else_if;
			t2 = 42;
			map[t1] = t2;
			t4 = s5 + 1;
			rastore[t4] = 0; //Ra of program to call printLabyrinth
			printLabyrinth();

				s5 = s5 + 1;
				t9 = t1 + 1;
				indextemp[s5] = t9; //index + 1 - Case 1
				rastore[s5] = 0; //Ra of program to call recursively the makeMove
				makeMove();
				t5 = returns[s5];  //After recursive call of makeMove, get the return value
				s5 = s5 - 1; //After recursive call of makeMove, revert the index
				t1 = indextemp[s5];
				t9 = t1 + 1;
				if(t5 != s7) goto if_ifception_1;
					t2 = 35;
					map[t1] = (char)t2;
					returns[s5] = s7;
					t8 = s5 - 1;
					ra = rastore[t8];
					return ra;
			if_ifception_1:
				s5 = s5 + s0;
				t9 = t1 + s0;
				indextemp[s5] = t9; //index + W - Case 2
				rastore[s5] = 0; //Ra of program to call recursively the makeMove
				makeMove();
				t5 = returns[s5];  //After recursive call of makeMove, get the return value
				s5 = s5 - s0; //After recursive call of makeMove, revert the index
				t1 = indextemp[s5];
				t9 = t1 + s0;
				if(t5 != s7) goto if_ifception_2;
					t2 = 35;
					map[t1] = (char)t2;
					returns[s5] = s7;
					t8 = s5 - 1;
					ra = rastore[t8];
					return ra;
			if_ifception_2:
				s5 = s5 - 1;
				t9 = t1 - 1;
				indextemp[s5] = t9; //index + W - Case 2
				rastore[s5] = 0; //Ra of program to call recursively the makeMove
				makeMove();
				t5 = returns[s5];  //After recursive call of makeMove, get the return value
				s5 = s5 + 1; //After recursive call of makeMove, revert the index
				t1 = indextemp[s5];
				t9 = t1 - 1;
				if(t5 != s7) goto if_ifception_3;
					t2 = 35;
					map[t1] = (char)t2;
					returns[s5] = s7;
					t8 = s5 - 1;
					ra = rastore[t8];
					return ra;
			if_ifception_3:
				s5 = s5 - s0;
				t9 = t1 - s0;
				indextemp[s5] = t9; //index + W - Case 2
				rastore[s5] = 0; //Ra of program to call recursively the makeMove
				makeMove();
				t5 = returns[s5];  //After recursive call of makeMove, get the return value
				s5 = s5 + s0; //After recursive call of makeMove, revert the index
				t1 = indextemp[s5];
				t9 = t1 - s0;
				if(t5 != s7) goto case_end;
					t2 = 35;
					map[t1] = (char)t2;
					returns[s5] = s7;
					t8 = s5 - 1;
					ra = rastore[t8];
					return ra;
	case_else_if:
		t2 = 64;
		t3 = (int)map[t1];
		if(t2 != t3) goto case_end;
		t2 = 37;
		map[t1] = (char)t2;
		t9 = t1 + 1;
		rastore[t9] = 0; //Ra of program to call printLabyrinth
		printLabyrinth();
		returns[s5] = s7;
		t8 = s5 - 1;
		ra = rastore[t8];
		return ra;
	case_end:
		returns[s5] = ZERO;
		t8 = s5 - 1;
		ra = rastore[t8];
		return ra;
}
