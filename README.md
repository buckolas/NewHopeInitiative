[New Hope Initiative (NHI) - Internal Tracking Tool](http://newhopeinitiative.org)
====================================================

This application is intended for use by the New Hope Initiative staff members. It was built with the intended benefit for the children that come into the care of the organization by tracking their illnesses, medical history, etc so that the organization monitor each child's needs and meet them accordingly. 

More information about the organization can be found on the [New Hope Initiative website](http://newhopeinitiative.org).

Only those with an existing account will be able to [view this website]() in full production. To obtain an account, you must be affiliated with the organization and need to contact a member of the NHI Board of Directors. 

The data used to populate this website will be stored separately and will not be distributed.

If you want to use the code from this application, clone the repo, `git clone git@github.com:buckolas/NewHopeInitiative.git`, or [download the latest release](https://github.com/buckolas/NewHopeInitiative/zipball/master).



Future Work
-----------

Since this is an internal-use only tool built in my spare time, I will push out updates when I am able depending on the amount of work involved. Priority communicated to me by NHI staff for each outstanding issue will be used to set the order in which fixes/changes are released. 

I am very lazy with Git at the moment, so who knows what sort of release format I will follow. Most likely everything will be released as major.

Some ideas I have at the moment for upcoming releases (after the initial deployment) are:
- An advanced search feature.
- A bulk edit capability (for moving multiple children to the next grade, deleting, etc).
- Displaying multiple photos per child (we currently allow 1 per child but have 2 available on a thumb drive and would like to allow even more; however, storage needs to get sorted first).
- Perhaps the ability to edit a child/user's information inline in the Show view instead of having to go to a separate Edit view.
- Make some of the selection lists more configurable by administrators (ie. school grade levels)
- Additional roles to limit user capability for destructive actions like deleting, or to limit some users to viewing data only (no editing)
- Internal cleanup



Dependencies
------------

twitter-bootstrap-rails

authlogic

carrierwave

simple_form

will_paginate



Bug tracker
-----------

Have a bug? Please create an issue here on GitHub!

https://github.com/buckolas/NewHopeInitiative/issues



Development Team 
----------------

**Mike Prendergast**

Yep, just me.



Copyright and License
---------------------

Copyright 2012 New Hope Initiative

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.