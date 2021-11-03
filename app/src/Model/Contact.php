<?php

namespace App\Model;

use Page;
use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;

class Contact extends DataObject
{

    private static $db = [
        'Title' => 'Varchar(255)',
        'Address' => 'Text',
        'Email' => 'Varchar(255)',
    ];

    private static $table_name = 'Contact';

    private static $has_one = [
        'Image' => Image::class,
        'Page' => Page::class
    ];

    private static $owns = [
        'Image'
    ];
}