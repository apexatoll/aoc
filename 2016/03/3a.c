#include <stdio.h>

int main(){
	FILE *fpt;
	char lines[5000][100];
	int nums[5000][3];
	int c, i = 0, nLines = 0;
	int firstSpace;
	fpt = fopen("input", "r");
	while((c = fgetc(fpt)) != EOF){
		if(c != ' ' && c != '\n'){
			lines[nLines][i] = c;
			i++;
			firstSpace = 1;
		}
		else{
			if(firstSpace == 1){
				if(c == ' '){
					lines[nLines][i] = c;
					i++;
				}else if(c == '\n'){
					i = 0;
					nLines++;
				}
				firstSpace = 0;
			}
		}
	}
	for(int k = 0; k < nLines; k++){
		for(int j = 0; j < 100; j++){
			printf("%c", lines[k][j]);
		}
		printf("\n");
	}
}
