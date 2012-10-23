<?php
var_dump(time());
exec('echo a', $a, $arr);
file_put_contents('/Users/yanagikenji/.vim/temp', $arr);
$a = file('/Users/yanagikenji/tags');
var_dump($a);
