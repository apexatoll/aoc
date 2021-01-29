#include <stdio.h>
#include <string.h>
int main(){
	FILE *ptr;
	int c, i=0, j=0;
	char input[10][5000];
	char keys[5][5] = {
		{'x', 'x', '1', 'x', 'x'},
		{'x', '2', '3', '4', 'x'},
		{'5', '6', '7', '8', '9'},
		{'x', 'A', 'B', 'C', 'x'},
		{'x', 'x', 'D', 'x', 'x'}
	};
	ptr = fopen("input", "r");
	while((c = fgetc(ptr)) != EOF){
		if(c != '\n'){
			input[j][i] = c;
			i++;
		}else{
			input[j][i] = '\n';
			i = 0;
			j++;
		}
	}
	int x = 0, y = 2;
	int nLines = j;
	for(int line = 0; line < nLines; line++){
		for(int cmd = 0; cmd < strlen(input[line]); cmd++){
			switch(input[line][cmd]){
				case 'U':
					if(y > 0 && (keys[y-1][x] != 'x')) y--;
					break;
				case 'D':
					if(y < 4 && (keys[y+1][x] != 'x')) y++;
					break;
				case 'L':
					if(x > 0 && (keys[y][x-1] != 'x')) x--;
					break;
				case 'R':
					if(x < 4 && (keys[y][x+1] != 'x')) x++;
					break;
				case '\n':
					printf("%c", keys[y][x]);
					break;
			}
		}
	}
	return 0;
}
