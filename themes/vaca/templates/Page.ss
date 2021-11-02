<!DOCTYPE html>
<html lang="en">
<head>
    <% base_tag %>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
</head>
<body>
    <header class="header" role="banner">
        <h1>$SiteConfig.Title</h1>
    </header>
    <section aria-label="Banner">
        <% if $Photo %>
            <h4>Banner exists</h4>
        <% else %>
            <h4>Banner doesn't notent exist</h4>    
        <% end_if %>
        $Photo
        $Content
    </section>
    <section aria-label="View Products">
        <h2>View products</h2>
    </section>
    <script>
        console.log("Hello work!");
    </script>
</body>
</html>