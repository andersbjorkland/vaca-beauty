# VACA Beauty 
## Overview
This is a showcase of my programming prowess for a position at Kreationsbyrån. This project is built in Silverstripe with the power of Bootstrap.


## Reflections
* Namespace seems not to be very intuitive with SilverStripe. I could not manage to add a route in `routes.yml` that pointed to `App\ArticlesController`. I resolved to make the controller without namespace.
* Returning Images as json required some debugging to do. I had to set `$owns`, then in the returning function I had to go into the product to get its image, upon which I got the URL.


