#include <stdio.h>
#include <math.h>
 
int main(){
	FILE *fptr;
	int c;
	int masses[100];
	int buffer[100];
	fptr = fopen("input", "r");
	int i = 0, j = 0;
	while((c = fgetc(fptr)) != EOF){
		if(c != '\n'){
			buffer[i] = c;
			i++;
		}else{
			for(j = i; j >= i; j--){
				int num = buffer[j];
				printf("%d ", num);
			}
			i = 0;
			/*masses[k]=mass;*/
		}
	}
	return 0;
}
