#include <stdio.h>
int countLines(FILE *fpt);
char countNeighbours(int x, int y, int strCount, int lineCount, char lines[]);

int main(){
	FILE *fpt;
	char lines[1000][1000];
	int c; int i = 0; int j = 0;
	int strCount;
	fpt = fopen("temp/input", "r");
	while((c=fgetc(fpt)) != EOF){
		if(c != '\n'){
			lines[i][j] = c;
			j++;
		}else{
			i++;
			strCount=j;
			j=0;
		} 
	}
	int lineCount = i;
	printf("%d", lineCount);
	char character = countNeighbours(0, 0, strCount, lineCount);
	printf("%c", character);
}
int countNeighbours(int x, int y, int strCount, int lineCount, char lines[]){
	int xArr[3] = {0, 1, -1};
	int yArr[3] = {0, 1, -1};
	for(int i = 0; i < 3; i++){
		int xNew = xArr[i] + x;
		for(int j = 0; i < 3; i++){
			int yNew = yArr[j] + y;
			if(xNew >= 0 && xNew < strCount){
				if(yNew >=0 && yNew < lineCount){
					char character = lines[xNew][yNew];
					return character;
				}
			}
		}
	}
}
