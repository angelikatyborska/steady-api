# Task definition

There is a simple formula which publishers can use to predict their earnings with Steady: 5% of their regular readers would give them 5 Euros each.

Write an API using Phoenix or another framework you feel comfortable with that helps publishers estimate their earnings. Write it in a way you would feel comfortable deploying to a production system.

When you’re done, please publish the project on Github and send us a link to the repository.

The API should do the following:
- Publishers call `/api/earnings` to receive JSON containing their estimated earnings.
- The only required parameter is `audience_count`, the number of their regular readers.
- Optional parameters are:
  - `conversion_percentage` (Integer): Percentage value of regular readers that will become paying members. Default value is 5.
  - `monthly_amount_in_cents_per_user` (Integer): Value representing the amount (in cents) each member will pay per month. Default ist 500.
- The API should return all input parameter plus:
  - `predicted_monthly_earning_in_cents` (Integer): Value representing the predicted amount the publisher will earn with the given parameters per month (in cents).
- The returned JSON should look like 
```JS
{
  audience_count: x, 
  conversion_percentage: y, 
  monthly_amount_in_cents_per_user: z, 
  predicted_monthly_earnings_in_cents:  ?
}
```

### Example:

Request:
`/api/earnings?audience_count=10000&conversion_percentage=10&monthly_amount_in_cents_per_user=400`

Response:
```JS
{
  audience_count: 10000,
  conversion_percentage: 10,
  monthly_amount_in_cents_per_user: 400,
  predicted_monthly_earnings_in_cents: 400000
}
```
