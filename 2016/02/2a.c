#include <stdio.h>
#include <string.h>

int main(){
	FILE *ptr;
	int c, i=0, j=0;
	char input[10][5000];
	int x = 1, y = 1;
	int keys[3][3] = {
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 9}
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
	int nLines = j;
	for(int line = 0; line < nLines; line++){
		for(int cmd = 0; cmd < strlen(input[line]); cmd++){
			switch(input[line][cmd]){
				case 'U':
					if(y > 0) y--;
					break;
				case 'D':
					if(y < 2) y++;
					break;
				case 'L':
					if(x > 0) x--;
					break;
				case 'R':
					if(x < 2) x++;
					break;
				case '\n':
					printf("%d", keys[y][x]);
					break;
			}
		}
	}
	return 0;
}
