<?php 

namespace App\Admin;

use App\Model\Contact;
use SilverStripe\Admin\ModelAdmin;

class ContactAdmin extends ModelAdmin
{
    private static $managed_models = [
        Contact::class
    ];

    private static $url_segment = 'contacts';

    private static $menu_title = 'Contacts';
}