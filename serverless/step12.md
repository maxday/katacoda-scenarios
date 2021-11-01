A new Datadog account has been created for you, you can see login details with  
`creds`{{execute}}`

[Sign into Datadog](https://app.datadoghq.com/account/login).

Then, select `APM` > `Traces` on the left menu

In a production-like environement, it will be unlikely to have traces coming from only one single Lambda function.

As we have `tagged` our service with `first letter of firstname + lastname` you can filter those traces with `@service:XXX` (for instance `@service:mdavid`)

*Make sure you select a correct time span on the top right hand corner (1 hour for instance)*

You can apply a lot of different `filters`, for instance you can apply `@coldstart:true` to see only the invocations from a cold start

Feel to free to apply different filters!

If you open a `trace` by clicking on it, you should also be able to see `correlated logs`. Make sure you can find our previously added log which outputs the generated filename.
