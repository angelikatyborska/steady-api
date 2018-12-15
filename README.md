# SteadyAPI

This is a solution to a recruitment task. The task definition can be found in `TASK.md`.

## What I did

I added a single endpoint that estimates earnings:
```bash
$ curl 'http://localhost:4000/api/earnings?audience_count=4000&conversion_percentage=8&monthly_amount_in_cents_per_user=700' | jq .
{
  "audience_count": 4000,
  "conversion_percentage": 8,
  "monthly_amount_in_cents_per_user": 700,
  "predicted_monthly_earning_in_cents": 224000
}
```

It validates the params:
```bash
$ curl 'http://localhost:4000/api/earnings?audience_count=1000&conversion_percentage=0.5' | jq .
{
  "error": {
    "reason": "value of 'conversion_percentage' must be a non-negative integer (got \"0.5\")",
    "status": 422
  }
}
```

Everything else returns an error (when run with `MIX_ENV=prod`):
```bash
$ curl 'http://localhost:4000/banana' | jq .
{
  "error": {
    "reason": "Not Found",
    "status": 404
  }
}
```

I also added CORS support which is necessary for the API to be usable by any browser client:
```bash
$ curl 'http://localhost:4000/api/earnings?audience_count=1000' -I -X OPTIONS -H 'Origin: http://example.com'
HTTP/1.1 204 No Content
access-control-allow-credentials: true
access-control-allow-headers: Authorization,Content-Type,Accept,Origin,User-Agent,DNT,Cache-Control,X-Mx-ReqToken,Keep-Alive,X-Requested-With,If-Modified-Since,X-CSRF-Token
access-control-allow-methods: GET,POST,PUT,PATCH,DELETE,OPTIONS
access-control-allow-origin: http://example.com
access-control-expose-headers:
access-control-max-age: 1728000
cache-control: max-age=0, private, must-revalidate
date: Sat, 15 Dec 2018 12:57:40 GMT
server: Cowboy
vary: Origin
x-request-id: 2lo85t8kpl01c0r35c0000t2
```

Allowed origins can be configured in production by providing a comma-separated list of domains in a `CORS_ORIGIN` variable:
 `CORS_ORIGIN='http://example.com,http://example.ru' MIX_ENV=prod mix phx.server`.

## What I did not do

While the task says:
> Write it in a way you would feel comfortable deploying to a production system

I am knowingly omitting certain details that I consider necessary for a production-ready app:
- Any configuration with regard to HTTPS as it depends on the infrastructure which component does SSL termination.
- A health check endpoint as it would only be useful in certain deployment contexts (eg. a Kubernetes cluster, an AWS Elastic Beanstalk application).
- API documentation intended for external users due to the limited time for the task.
- Preparing the release process by adding production Docker images and/or using Distillery due to the limited time for the task.

## Setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
