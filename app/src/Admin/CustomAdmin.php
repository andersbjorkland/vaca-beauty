<?php 

namespace App\Admin;

use App\Model\Product;
use SilverStripe\Admin\ModelAdmin;

class CustomAdmin extends ModelAdmin
{
    private static $managed_models = [
        Product::class
    ];

    private static $url_segment = 'products';

    private static $menu_title = 'Products';
}