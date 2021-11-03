<!DOCTYPE html>
<html lang="en">
<head>
    <% base_tag %>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<% require themedCSS('styles') %>
</head>
<body>
    <header class="header" role="banner">
        <img src="/_resources/themes/vaca/images/VACA-logo.svg" alt="">
    </header>
    <section class="banner" aria-label="Banner">
        <div class="banner-image-container">
            $Photo
        </div>
        $Content
    </section>
    <section class="section" aria-label="View Products">
        <h2>View products</h2>
        <div class="button-container">
            <button class="btn bg-white" onclick="sortByPrice()">Price</button>
            <button class="btn bg-white" onclick="sortByNew()">New</button>
        </div>
        <div id="products-container" class="grid-container">
        </div>
    </section>

    <script>
        const productsContainer = document.getElementById("products-container");

        const productTemplate = (title, description, image, imageDescription, price) => {
            const productWrapper = document.createElement('div');
            const imgWrapper = document.createElement('div');
            const imgElement = document.createElement('img');
            const h3Element = document.createElement('h3');
            const descriptionElement = document.createElement('p');
            const priceElement = document.createElement('p');

            if (image) {
                imgElement.setAttribute('src', image);
                imgElement.setAttribute('alt', imageDescription);
                imgElement.setAttribute('title', imageDescription);
                imgWrapper.appendChild(imgElement);
                imgWrapper.classList.add('product-image')
                productWrapper.appendChild(imgWrapper);
            }
            

            h3Element.innerText = title;
            descriptionElement.innerText = description;
            priceElement.innerText = price;

            productWrapper.appendChild(h3Element);
            productWrapper.appendChild(descriptionElement);
            productWrapper.appendChild(priceElement);
            productWrapper.classList.add('product');

            const template = `<div>
                <img src="${image}" alt="${imageDescription}" title="${imageDescription}" />
                <h3>${title}</h3>
                <p>${description}</p>
                <p>${price}</p>
            </div>`;

            return productWrapper;
        };

        function fetchProducts() {
            fetch('/products')
            .then(response => {
                return response.json();
            })
            .then(result => {
                console.log(result);

                const products = result.Products ?? null;
                
                let productsElements = null;

                if (products) {
                    for (let i = 0; i < products.length; i++) {
                        productsElement = productTemplate(products[i].Title, products[i].Description, products[i].Image, products[i].ImageDescription, products[i].Price);
                        productsContainer.appendChild(productsElement);
                    }
                }
            })
            .catch(error => console.error(error));
        }

        function sortByPrice() {
            console.log("sort by price!");
            fetch('/products?sortBy=PriceAmount&asc=0')
            .then(response => {
                return response.json();
            })
            .then(result => {
                console.log(result);

                const products = result.Products ?? null;
                
                let productsElements = null;

                if (products) {
                    productsContainer.innerHTML = "";
                    for (let i = 0; i < products.length; i++) {
                        productsElement = productTemplate(products[i].Title, products[i].Description, products[i].Image, products[i].ImageDescription, products[i].Price);
                        productsContainer.appendChild(productsElement);
                    }
                }
            })
            .catch(error => console.error(error));
        }

        function sortByNew() {
            console.log("sort by new!");
            fetch('/products?sortBy=Created&asc=0')
            .then(response => {
                return response.json();
            })
            .then(result => {
                console.log(result);

                const products = result.Products ?? null;
                
                let productsElements = null;

                if (products) {
                    productsContainer.innerHTML = "";
                    for (let i = 0; i < products.length; i++) {
                        productsElement = productTemplate(products[i].Title, products[i].Description, products[i].Image, products[i].ImageDescription, products[i].Price);
                        productsContainer.appendChild(productsElement);
                    }
                }
            })
            .catch(error => console.error(error));
        }
        
        fetchProducts();
    </script>
</body>
</html>