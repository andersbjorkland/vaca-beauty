<?php

namespace App\Model;

use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;

class Product extends DataObject
{

    private static $db = [
        'Title' => 'Varchar(255)',
        'Description' => 'Text',
        'Price' => 'Money',
        'ImageDescription' => 'Text'
    ];

    private static $table_name = 'Product';

    private static $has_one = [
        'Image' => Image::class
    ];
}