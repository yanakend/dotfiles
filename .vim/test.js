
var a = '1001001000';
for (var i = 0, count=a.length; i < count; i++) {
	if (a.charAt(i) == 1) {
		var switchNo = i + 1;
		print(switchNo + "\n");
	}
}
