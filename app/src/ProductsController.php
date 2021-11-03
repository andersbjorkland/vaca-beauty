<?php

use App\Model\Product;
use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPRequest;

class ProductsController extends Controller
{
    private static $allowed_actions = [
        'index',
    ];
    
    private static $url_handlers = [
        'index' => 'index',
    ];

    public function index(HTTPRequest $request)
    {

        $vars = $request->getVars();

        $sort = null;
        if (key_exists("sortBy", $vars)) {
            $sort = $vars["sortBy"];
        }

        $asc = 'ASC';
        if (key_exists("Asc", $vars)) {
            if ($vars["Asc"] != 1) {
                $asc = 'DESC';
            }
        }


        $productQueryResult = null;
        if ($sort) {
            $productQueryResult = Product::get()->sort($sort, $asc)->limit(4);
        } else {
            $productQueryResult = Product::get()->limit(4);
        }

        $products = [];
        foreach ($productQueryResult as $productResult) {

            $products[] = [
                "ID" => $productResult->ID,
                "Title" => $productResult->Title,
                "Description" => $productResult->Description,
                "Price" => $productResult->Price->getValue(),
                "ImageDescription" => $productResult->ImageDescription,
                "Image" => $productResult->Image->URL,
            ];

        }

        $result = ["Example" => "Hello Async", "Products" => $products];

        $this->response->addHeader('Content-Type', 'application/json');
        return json_encode($result);
    }
}