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

        $productQueryResult = Product::get()->limit(4);
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