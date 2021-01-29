#include <iostream>
#include <fstream>
#include <vector>
#include <regex>
using namespace std;

int main(){
	string instring;
	vector<string> passwords;
	fstream input("input");
	while(getline(input, instring)){
		passwords.push_back(instring);
	}
	regex nums("[0-9]+");
	for(int i = 0; i < passwords.size(); i++){
		cout << passwords[i] << endl;
		nums.regmatch(passwords[i]);
	}
}
