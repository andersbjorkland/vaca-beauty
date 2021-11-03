<?php

namespace {

    use App\Model\Contact;
    use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
    use SilverStripe\CMS\Model\SiteTree;
    use SilverStripe\Forms\DropdownField;

class Page extends SiteTree
    {
        private static $db = [];

        private static $has_one = [
            'Photo' => Image::class,
            'Contact' => Contact::class
        ];

        private static $owns = [
            'Photo',
            'Contact'
        ];


        public function getCMSFields() {
            $fields = parent::getCMSFields();

            $fields->addFieldToTab('Root.Main', UploadField::create(
                'Photo',
                'Banner Photo'
            ));

            $fields->addFieldsToTab('Root.Main', DropdownField::create(
                'ContactID',
                'Contact',
                Contact::get()->map('ID', 'Title')
            ));

            return $fields;
        }
    }
}
