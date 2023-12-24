<?php
// 用于获取当前访问次数并返回给前端

$file = 'ad_count.txt'; // 存储访问次数的文件

if (file_exists($file)) {
    $visitCount = (int)file_get_contents($file); // 从文件中获取访问次数
    echo $visitCount;
} else {
    echo '0';
}
?>
