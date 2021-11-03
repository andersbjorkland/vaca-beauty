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
        <div id="products-pagination" class="pagination-container"></div>
    </section>

    <section class="banner">
        <div class="banner-image-container">
            <img alt="image 2" src="/_resources/themes/vaca/images/banner2.jpg" loading="lazy">
        </div>
        <h2>Get in touch</h2>
        <p>47 Chandos Place, London, WC2N 4HS</p>
        <a href="#">Contact us</a>
    </section>
    <footer>
        <div class="inner-container">
            <img src="/_resources/themes/vaca/images/VACA-logo.svg" alt="">
            <div>
                <a href="#">Privacy Policy</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Privacy Policy</a>
            </div>
        </div>
    </footer>

    <script>
        const productsContainer = document.getElementById("products-container");
        const paginationContainer = document.getElementById("products-pagination");

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

        const pagesButtonGenerator = (pagination) => {
            const paginationButton = document.createElement('button');
            paginationButton.setAttribute('onclick', `paginationFetch('${pagination.Link}')`);
            paginationButton.classList.add("btn");
            if (pagination.CurrentBool) {
                paginationButton.classList.add("active");
            }
            paginationButton.innerText = pagination.PageNum;

            return paginationButton;
        }

        const generateAllPagination = (pagination) => {
            paginationContainer.innerHTML = "";

            if (pagination.Previous) {
                    const PreviousButtonElement = document.createElement('button');
                    PreviousButtonElement.setAttribute('onclick', `paginationFetch('${pagination.Previous}')`);
                    PreviousButtonElement.classList.add('btn');
                    PreviousButtonElement.innerText = '<';
                    paginationContainer.appendChild(PreviousButtonElement);
            }

            if (pagination.Pages) {
                for (let i = 0; i < pagination.Pages.length; i++) {
                    paginationContainer.appendChild(pagesButtonGenerator(pagination.Pages[i]));
                }
            }

            if (pagination.Next) {
                    const NextButtonElement = document.createElement('button');
                    NextButtonElement.setAttribute('onclick', `paginationFetch('${pagination.Next}')`);
                    NextButtonElement.classList.add('btn');
                    NextButtonElement.innerText = '>';
                    paginationContainer.appendChild(NextButtonElement);
            }
        }

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

                const pagination = result.Pagination ?? null;
                if (pagination) {
                    generateAllPagination(pagination);
                }

            })
            .catch(error => console.error(error));
        }

        function sortByPrice() {
            console.log("sort by price!");
            fetchBySort('PriceAmount');
        }

        function sortByNew() {
            console.log("sort by new!");
            fetchBySort('Created');
        }

        function paginationFetch(query) {
            console.log("Pagination fetch!", query);
            fetch(query)
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

                    const pagination = result.Pagination ?? null;
                    if (pagination) {
                        generateAllPagination(pagination);
                    }
                    
                })
                .catch(error => console.error(error));
        }

        function fetchBySort(sortBy, start=0, sortAscending = false) {
            fetch(`/products?sortBy=${sortBy}&asc=${sortAscending ? 1 : 0}&start=${start}`)
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

                    const pagination = result.Pagination ?? null;
                    if (pagination) {
                        generateAllPagination(pagination);
                    }
                    
                })
                .catch(error => console.error(error));
        }
        
        fetchProducts();
    </script>
</body>
</html>