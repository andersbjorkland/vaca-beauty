<?php

use App\Model\Product;
use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\ORM\PaginatedList;

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
            $productQueryResult = Product::get()->sort($sort, $asc);
        } else {
            $productQueryResult = Product::get();
        }

        $paginatedProducts = (new PaginatedList($productQueryResult, $request))->setPageLength(4);
        $previousPage = $paginatedProducts->PrevLink();
        $nextPage = $paginatedProducts->NextLink();
        $pagination["Pages"] =  $paginatedProducts->PaginationSummary()->toNestedArray();
        $pagination["Previous"] = $previousPage;
        $pagination["Next"] = $nextPage;


        $products = [];
        foreach ($paginatedProducts as $productResult) {

            $products[] = [
                "ID" => $productResult->ID,
                "Title" => $productResult->Title,
                "Description" => $productResult->Description,
                "Price" => $productResult->Price->getValue(),
                "ImageDescription" => $productResult->ImageDescription,
                "Image" => $productResult->Image->URL,
            ];

        }

        $result = ["Example" => "Hello Async", "Products" => $products, "Pagination" => $pagination];

        $this->response->addHeader('Content-Type', 'application/json');
        return json_encode($result);
    }
}