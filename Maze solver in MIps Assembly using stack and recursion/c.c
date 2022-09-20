#include <stdio.h>
#include <stdlib.h>

int W = 21;
int H = 11;
int startX = 1;
int TotalElements = 231;
char temp[100];
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
    printLabyrinth();
    makeMove(startX);
    printf("\nThe best solution for this maze is :\n");
    printLabyrinth();
    return 0;
}

void printLabyrinth(void)
{
    int i, j, k = 0;
    usleep(200000);
    printf("Labyrinth:\n");
    for(i=0;i<H;i++)
    {
        for(j=0;j<W;j++)
        {
            temp[j] = map[k];
            k++;
        }
        temp[j+1] = '\0';
        printf("%s\n", temp);
    }
}

int makeMove(int index)
{
    if(index < 0 || index >= TotalElements)
        return 0;
    if(map[index] == '.')
    {
        map[index] = '*';
        printLabyrinth();
        if(makeMove(index+1) == 1)
        {
            map[index] = '#';
            return 1;
        }
        if(makeMove(index+W) == 1)
        {
            map[index] = '#';
            return 1;
        }
        if(makeMove(index-1) == 1)
        {
            map[index] = '#';
            return 1;
        }
        if(makeMove(index-W) == 1)
        {
            map[index] = '#';
            return 1;
        }
    }
    else if(map[index] == '@')
    {
        map[index] = '%';
        printLabyrinth();
        return 1;
    }
    return 0;
}
