[Sign into Datadog](https://app.datadoghq.com/account/login).

Then, select `APM` > `Traces` on the left menu

Remember, in this workshop we are all using the same AWS account, so your application in the only one which shows up in Datadog (like it will be the case in a real production environment).

As we have `tagged` our service with `first letter of firstname + lastname` you can filter those traces with `@service:XXX` (for instance `@service:mdavid`)

*Make sure you select a correct time span on the top right hand corner (1 hour for instance)*

You can apply a lot of different `filters`, for instance you can apply `@coldstart:true` to see only the invocations from a cold start

Feel to free to apply different filters!

If you open a `trace` by clicking on it, you should also be able to see `correlated logs`. Make sure you can find our previously added log which outputs the generated filename.
