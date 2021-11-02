<?php

namespace {

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
    use SilverStripe\CMS\Model\SiteTree;

class Page extends SiteTree
    {
        private static $db = [];

        private static $has_one = [
            'Photo' => Image::class
        ];

        private static $owns = [
            'Photo'
        ];


        public function getCMSFields() {
            $fields = parent::getCMSFields();

            $fields->addFieldToTab('Root.Main', UploadField::create(
                'Photo',
                'Banner Photo'
            ));

            return $fields;
        }
    }
}
