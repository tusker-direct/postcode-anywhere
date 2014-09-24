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

## Small disclaimer

The general architecture of this Gem is completely ripped off from that of the
[Twitter API Gem](https://github.com/sferik/twitter) so credit to be directed that way.
This has been used mainly because this structure generally works well for us
and it's well tested.

## Usage

This Gem consists of a numer of available clients for each key service available from
Postcode Anywhere

The client can be configured upon instantiation.

```ruby
client = PostcodeAnywhere::CleansePlus::Client.new(
  license_key:  'YOUR_API_KEY',
)
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
| `PostcodeAnywhere::Error::UnknownKey`              | The cause of the error is unknown but details have been passed to our support staff who will investigate.                                       | These problems are typically short lived and are often resolved by trying again in a few minutes.                                                                                                                                                             |
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
| `PostcodeAnywhere::Error::KeyDailyLimitExceeded`   | The daily limit on the key has been exceeded.                                                                                                   | Alter the daily limit on the key. Check the usage details first to see if usage is normal.                                                                                                                                                                    |

## Contributing

1. Fork it ( https://github.com/simplemerchant/postcode_anywhere/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
