#! /usr/bin/sudo /usr/local/bin/php
<?php
$currentDir = dirname($_SERVER['PHP_SELF']);
$files = array(
	'direct.png','full_ascii.png','full_katakana.png','half_ascii.png','half_katakana.png','hiragana.png',
	'direct.tiff','full_ascii.tiff','full_katakana.tiff','half_ascii.tiff','half_katakana.tiff','hiragana.tiff',
);
foreach ($files as $file) :
	$handle = fopen('/Library/Input Methods/GoogleJapaneseInput.app/Contents/Resources/'.$file,'w+');
	fwrite($handle,file_get_contents($currentDir.'/'.$file));
	fclose($handle);
endforeach;
?>
