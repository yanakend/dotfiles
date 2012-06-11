<?php

$text = '%from_owner_id%が%to_owner_id%を%group_name%に誘ってます';


$replaceTexts = array(
	'id' => "4f7846efbd6831e05d00",
	'owner_id'=>'2349075',
	'text_id' => '1',
	'is_read'=>1,
	'is_notified' => 0,
	'options'=>array(
		'to_owner_id'=>'23490750',
		'from_owner_id'=>'2349076',
		'group_name'=>'竹ちゃんズ',
	),
	'created' => '',
	'modified' => '',
);


var_dump($text);
foreach ($replaceTexts['options'] as $key => $replaceText) {
    $text = str_replace("%{$key}%", $replaceText, $text);
}
var_dump($text);

