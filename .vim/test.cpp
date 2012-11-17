#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverse (char* str);
bool is_unique_string (char* str);
int fibonnacci (int i);

int main (int argc, char* argv[]) {

	char str[] = "12344";
    reverse(str);
	printf("%d\n", fibonnacci(11));
    return 0;
}

// 文字列反転
void reverse (char* str) {
	if (str == NULL) {
        return;
	}
	int max = strlen(str) - 1;
	for (int i = 0; i < ((max + 1) / 2); ++i) {
		char swap = str[i];
        str[i] = str[max - i];
        str[max - i] = swap;
	}
}

// 文字列ユニークチェック
bool is_unique_string (char* str) {
	if (str == NULL) {
        return false;
	}
	int max = strlen(str) - 1;
	// 最後の文字列は調査しなくてもユニークである
	for (int i = 0; i < (max - 1); ++i) {
		char check_char = str[i];
		for (int j = (i + 1); j < max; ++j) {
			if (check_char == str[j]) {
				return false;
			}
		}
	}
	return true;
}

int fibonnacci (int i) {
	if (i == 0) return 0;
	if (i == 1) return 1;

	return fibonnacci(i - 1) + fibonnacci(i - 2);
}








