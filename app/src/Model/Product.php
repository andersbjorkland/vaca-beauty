<?php

namespace App\Model;

use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;

class Product extends DataObject
{

    private static $db = [
        'Title' => 'Varchar(255)',
        'Description' => 'HTMLText',
        'Price' => 'Currency'
    ];

    private static $table_name = 'Product';

    private static $has_one = [
        'Image' => Image::class
    ];
}