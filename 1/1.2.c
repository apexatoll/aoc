#include <stdio.h>

int main(){
	FILE *fptr;
	int input[200];
	fptr = fopen("/Users/welham/prog/aoc/1/input", "r");
	if(fptr == NULL){
		fptr = fopen("/Users/christian/prog/aoc/1/input", "r");
	}
	int i = 0;
	while(fscanf(fptr, "%d", &input[i++]) == 1);
	fclose(fptr);
	for(int a = 0; a < 200; a++){
		int numa = input[a];
		for(int b = 0; b < 200; b++){
			int numb = input[b];
			for(int c = 0; c < 200; c++){
				int numc = input[c];
				if((a != b) && (b != c) && (a != c)){
					if(numa + numb + numc == 2020){
						int result = numa * numb * numc;
						printf("Number 1: %d\n", numa);
						printf("Number 2: %d\n", numb);
						printf("Number 3: %d\n", numc);
						printf("Result: %d\n", result);
						return 0;
					}
				}
			}
		}
	}
}
