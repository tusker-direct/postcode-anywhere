# Postcode Anywhere

[ ![Codeship Status for simplemerchant/postcode_anywhere](https://codeship.io/projects/ade82b60-260e-0132-ce11-5220aac52c67/status)](https://codeship.io/projects/37329)

This is the Ruby gem for interacting with the [Postcode Anywhere API](http://www.postcodeanywhere.co.uk/support/webservices/) API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postcode_anywhere'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postcode_anywhere

## Usage

This Gem consists of a numer of available clients for each key service available from
Postcode Anywhere

### Configuration

Each client is configured upon instantiation:

```ruby
client = PostcodeAnywhere::CapturePlus::Client.new(
  # Mandatory
  api_key:  'YOUR_API_KEY',

  # Optional: If not set, defaults to: 'Postcode Anywhere Ruby Gem/1.0.1'
  user_agent: 'YOUR_APPLICATION_USER_AGENT'
)
```

### [CapturePlus Address Validation](http://www.postcodeanywhere.co.uk/address-validation/api/)

Addresses can be searched upon by a number of different means. An array of results is always
returned:

#### General search

This searches everyhing:

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query 'buckingham pal'
  results.count
  # => 7
  results.first.text
  # => "Buckingham Palace, London, SW1A..."
```

#### By postcode

This searches by postcode:

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query_postcodes 'SW1A'
  # OR
  results = client.query 'SW1A', search_for: PostcodeAnywhere::CapturePlus::POSTCODE

  results.count
  # => 10
  results.first.text
  # => "SW1A 0AA"
```

#### By company

This searches by postcode:

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query_companies 'Asda'
  # OR
  results = client.query 'Asda', search_for: PostcodeAnywhere::CapturePlus::COMPANY

  results.count
  # => 7
  results.first.text
  # => "Asda Stores Ltd, Ipswich, IP1..."
```

#### By place

This searches by postcode:

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query_places 'Hyde park, london'
  # OR
  results = client.query 'Hyde park, london', search_for: PostcodeAnywhere::CapturePlus::PLACE

  results.count
  # => 7
  results.first.text
  # => "Hyde Park, London, W2..."
```

### Sub query and refinement

Some search results have a 'next' value of 'Find'. These can be queried into by using
a sub query:

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query_places 'Hyde park, london'
  hyde_park_result = results.first

  hyde_park_result.next
  # => "Find"

  hyde_park_sub_result = client.sub_query('park', hyde_park_result)

  hyde_park_sub_result.first.text
  # => => "Veranda Lodge, Metropolitan Police, The Royal Parks Operational Command Unit, The Old Police House, Hyde Park, London, W2..."
```

##### NOTE: Only search results which have the 'next' value of 'Find' will return a meaningful result. Results with a 'next' of 'Retrieve' should be retrieved (see below)

### Retrieval

The full details of a search result can be retrieved as follows:

##### IMPORTANT: Only search results which have the 'next' value of 'Retrieve' will return a result. Search results with 'next' of 'Find' need to be refined with a sub_query. (See above)

A retrieved result has a full set of available fields to it which are listed in the [postcode anywhere docs](http://www.postcodeanywhere.co.uk/support/webservice/captureplus/interactive/retrieve/2/)

```ruby
  client = PostcodeAnywhere::CapturePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  results = client.query_places 'Hyde park, london'
  hyde_park_result = results.first
  hyde_park_sub_result = client.sub_query('park', hyde_park_result)

  hyde_park_police_result = hyde_park_sub_result.first

  hyde_park_police = client.retrieve(hyde_park_police_result)

  hyde_park_police.department
  # => "The Royal Parks Operational Command Unit"

  hyde_park_police.postal_code
  # => => "W2 2UH"
```

### [Data Cleansing](http://www.postcodeanywhere.co.uk/Support/WebService/CleansePlus/Interactive/Cleanse/1/)

An address can be cleansed by using the CleansePlus client, as follows:

```ruby
  client = PostcodeAnywhere::CleansePlus::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  addresses = client.address_candidates_for 'London, SW1A 1AA'

  addresses.first.company
    # =>"Buckingham Palace"
```

The following fields are available on an address:

**udprn, company, department, line1, line2, line3, line4, line5, post_town, county,
postcode, mailsort, barcode, type, delivery_point_suffix, sub_building, building_name,
building_number, primary_street, secondary_street, double_dependent_locality,
dependent_locality, po_box**

### [Payment Validation](http://www.postcodeanywhere.co.uk/bank-account-validation/api/)

#### [Retrieve by sort code](http://www.postcodeanywhere.co.uk/Support/WebService/BankAccountValidation/Interactive/RetrieveBySortcode/1/)

A bank branch can be retrieved from a sort code:

```ruby
  client = PostcodeAnywhere::BankAccountValidation::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  branch = client.retrieve_by_sortcode '40-17-53'

  branch.contact_postcode
  # => "GL53 7RA"
  branch.bank
  # => "HSBC BANK PLC"
  branch.faster_payments_supported
  # => true
```

The following fields are available on a bank branch:

**bank, bank_bic, branch, branch_bic, contact_address_line1, contact_address_line2,
contact_post_town, contact_postcode, contact_phone, contact_fax,
faster_payments_supported, chaps_supported**

#### [Validate account](http://www.postcodeanywhere.co.uk/support/webservice/bankaccountvalidation/interactive/validate/2/)

A bank account number and sort code can be validated:

```ruby
  client = PostcodeAnywhere::BankAccountValidation::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  validation = client.validate_account('12345678','11-22-33')

  validation.is_correct
  # => true
```

The following fields are available for a validation:

**is_correct, is_direct_debit_capable, status_information, corrected_sort_code,
corrected_account_number, iban, bank, bank_bic, branch, branch_bic,
contact_address_line1, contact_address_line2, contact_post_town, contact_postcode,
contact_phone, contact_fax, faster_payments_supported, chaps_supported**

### [Email Validation](http://www.postcodeanywhere.co.uk/email-validation/api/)

#### [Validate email](http://www.postcodeanywhere.co.uk/Support/WebService/EmailValidation/Interactive/Validate/1.1/)

An email address can be validated:

```ruby
  client = PostcodeAnywhere::EmailValidation::Client.new(
    api_key:  'YOUR_API_KEY',
  )

  validation = client.validate_email_address('some_email_address@email.com')

  # Options then are

  validation.valid_format
  # => true
  validation.found_dns_record
  # => true
  validation.mail_server
  # => 'aspmx3.googlemail.com'
  validation.email
  # => 'some_email_address@email.com'
```

## Errors

If there is something critically wrong with the service, then the gem will throw a relevant
exception which may be one of:

```ruby
  PostcodeAnywhere::Error::BadRequest,
  PostcodeAnywhere::Error::Unauthorized,
  PostcodeAnywhere::Error::Forbidden,
  PostcodeAnywhere::Error::NotFound,
  PostcodeAnywhere::Error::NotAcceptable,
  PostcodeAnywhere::Error::RequestTimeout,
  PostcodeAnywhere::Error::UnprocessableEntity,
  PostcodeAnywhere::Error::TooManyRequests,
  PostcodeAnywhere::Error::InternalServerError,
  PostcodeAnywhere::Error::BadGateway,
  PostcodeAnywhere::Error::ServiceUnavailable,
  PostcodeAnywhere::Error::GatewayTimeout
```

However other errors, such as an invalid API key will throw an error where both a
**cause** and **resolution** should be available as such:

```ruby
begin
rescue PostcodeAnywhere::Error => e
  puts e.cause # => 'The key you are using to access the service was not found.'
  puts e.resolution # => 'Please check that the key is correct. It should be in the form AA11-AA11-AA11-AA11.'
end
```

Some Postcode Anywhere errors include:

| Error                                              | Cause                                                                                                                                           | Resolution                                                                                                                                                                                                                                                    |
|----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `PostcodeAnywhere::Error::UnknownError`            | The cause of the error is unknown but details have been passed to our support staff who will investigate.                                       | These problems are typically short lived and are often resolved by trying again in a few minutes.                                                                                                                                                             |
| `PostcodeAnywhere::Error::UnknownKey`              | The key you are using to access the service was not found.                                                                                      | Please check that the key is correct. It should be in the form AA11-AA11-AA11-AA11.                                                                                                                                                                           |
| `PostcodeAnywhere::Error::AccountOutOfCredit`      | Your account is either out of credit or has insufficient credit to service this request.                                                        | Please check your account balance and top it up if necessary.                                                                                                                                                                                                 |
| `PostcodeAnywhere::Error::IpDenied`                | The request was disallowed from the IP address.                                                                                                 | Check the security settings on the key first. If they look fine, please contact support as it may be from an IP address on our blacklist.                                                                                                                     |
| `PostcodeAnywhere::Error::UrlDenied`               | The request was disallowed from the URL.                                                                                                        | Check the security settings on the key first. If they look fine, please contact support as it may be from a URL on our blacklist.                                                                                                                             |
| `PostcodeAnywhere::Error::ServiceDeniedForKey`     | The requested web service is disallowed on this key.                                                                                            | Check the security settings on the key first. You can limit a key to certain web services.                                                                                                                                                                    |
| `PostcodeAnywhere::Error::ServiceDeniedForPlan`    | The requested web service is not currently available on your payment plan.                                                                      | Some services are only available in specific regions due to licensing restrictions. Please contact us for more information.                                                                                                                                   |
| `PostcodeAnywhere::Error::KeyDailyLimitExceeded`   | The daily limit on the key has been exceeded.                                                                                                   | Alter the daily limit on the key. Check the usage details first to see if usage is normal.                                                                                                                                                                    |
| `PostcodeAnywhere::Error::SurgeProtectorRunning`   | The surge protector is currently enabled and has temporarily suspended access to the account.                                                   | You can disable the surge protector at any time, but this is only recommended if you are running through a batch of requests.                                                                                                                                 |
| `PostcodeAnywhere::Error::SurgeProtectorTriggered` | An unusually large number of requests have been processed for your account so the surge protector has been enabled.                             | You can disable the surge protector at any time but this is only recommended if you are running through a batch of requests.                                                                                                                                  |
| `PostcodeAnywhere::Error::NoValidLicense`          | The request requires a valid license but none were found.                                                                                       | Please check your purchase history. You may be using a license that is no longer valid or of an incorrect type.                                                                                                                                               |
| `PostcodeAnywhere::Error::ManagementKeyRequired`   | To use this web service you require a management key. Management can be enabled on any key, but we advise you to use management keys with care. | Sign in to the website and create a new management key or change an existing key.                                                                                                                                                                             |
| `PostcodeAnywhere::Error::DemoLimitExceeded`       | The daily demonstration limit for this service or account has been exceeded.                                                                    | The limit will be reset at midnight tonight. If you would like the limit increased, please contact us.                                                                                                                                                        |
| `PostcodeAnywhere::Error::FreeLimitExceeded`       | You have used too many free web services.                                                                                                       | Our web services are designed to operate in stages. The first is usually a Find service followed by a Retrieve. If you use too many Finds without the corresponding number of Retrieves you will receive this error. For more information, please contact us. |
| `PostcodeAnywhere::Error::IncorrectKeyType`        | The type of key you're using isn't supported by this web service.                                                                               | This usually happens if you're using a user or server license with a web service that only supports transactional keys. Please use another key and try again.                                                                                                 |
| `PostcodeAnywhere::Error::KeyExpired`              | The key you are trying to use has expired.                                                                                                      | Please check that you are using the right key. A new one may have been issued if you recently renewed your key. Contact us if you have any questions.                                                                                                         |

## Small disclaimer

The general architecture of this Gem is taken from that of the
[Twitter API Gem](https://github.com/sferik/twitter) so credit to be directed that way.
This structure has been used mainly because this structure generally works well for us
at Simple Merchant and it's well tested.

## Contributing

1. Fork it ( https://github.com/simplemerchant/postcode_anywhere/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
