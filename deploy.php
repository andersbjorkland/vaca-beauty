<?php
namespace Deployer;

require 'recipe/symfony4.php';

host('andersse')
    ->set('deploy_path', '~/andersbjorkland.se/{{application}}')
    ->set('http_user', 'tmyyjr');

task('symlink:public', function() {
    run('{{bin/symlink}} ~/silver.andersbjorkland.se/vaca-beauty/public/*  ~/silver.andersbjorkland.se/public_html');
});