#include <iostream>
#include <sstream>
#include "cmathparser/cmathparser.h"

int main(int argc, char** argv){
	
	if (argc <= 1){
		std::cout << "Too Few Arguments" << std::endl;
		exit(1);
	}

	std::stringstream ss;

	for (int i = 1; i < argc; i++){
		ss << argv[i];
	}

	std::cout << "Answer: " << evaluate(ss.str().c_str()) << std::endl;

	return 0;
}
