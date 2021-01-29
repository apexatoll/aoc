#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

int main(){
	vector<int> nums;
	string stringin;
	int result, result2;
	ifstream input("input");
	while(getline(input, stringin)){
		nums.push_back(stoi(stringin));
	}
	for(int i = 0; i < nums.size(); i++){
		for(int j = 0; j < nums.size(); j++){
			if(nums[i] + nums[j] == 2020){
				result = nums[i] * nums[j];
				break;
			}
		}
	}
	for(int i = 0; i < nums.size(); i++){
		for(int j = 0; j < nums.size(); j++){
			for(int k = 0; k < nums.size(); k++){
				if(nums[i] + nums[j] + nums[k] == 2020){
					result2 = nums[i] * nums[j] * nums[k];
					break;
				}
			}
		}
	}
	cout << "Part one: " << result << endl;
	cout << "Part two: " << result2;
}
