## CodeWalkThrough:

  * This is a simple web api application to serve orders, and its fee calculation.
  * Data is served from json files in data folder. 
    Using config files are served to respective environment.
  * This app is a supervised app, which starts the Endpoint.
  * Endpoint is where web app layer sits and serves api request via Router.
  * Fee calculation is done in sequra.ex file
  * DataLoader module takes care of loading data into respective.
  * Query Helpers file is extended to Order module, 
    using which we query through the data.
  * Disburse module generates report which takes two inputs, list of orders and date.
    if date is not given it takes current date.
  * Oops, Did it in a single commit.

## Assumptions:
  
  * Week range is Monday - Sunday. when a random date is given the system finds the
    start of week (Monday), and end of week (Sunday).
  * Amount to be disbursed to a merchant for an order is:
    pay_merchant = order_amount - fee, which is rounded.
  * Due to time constraint, I went with Merchant/Shopper id over Merchant/Shopper name
    for urls
    ex: http://localhost:4040/disburse/merchants?date=01/01/2018
        http://localhost:4040/disburse/merchants/14?date=10/01/2018
        http://localhost:4040/merchant/2/orders
        http://localhost:4040/merchant/2/orders/completed
        http://localhost:4040/user/7/orders/completed
  * Disburse generates report only for a week, based on any given date. 
    if not given it picks current date and its week range.
  * Api authenication is not done here. its open.
  * I do know Ecto, but want to use file system. 
    Didn't want to add additional layer to the application.
  * As app talks more about orders, Query Helpers are extended only to Order, 
    if required, it can be easily extended to other modules.
  * Due to time contraint, skipped @type, @spec, and documentation

## Planned Improvement:

  * Create Date Helpers for date related operations.
  * Create module based routes using plug
    i.e: order_router, merchant_router
    ex: forward(/orders, to: Sequra.OrderRouter)
        forward(/users, to: Sequra.UserRouter)
        forward(/merchants, to: Sequra.MerchantRouter)
    or
    Move code from Router to respective modules.
    ex: for /orders/completed
        Order.completed(orders)
        Merchant.orders(orders, merchant_id) or Order.by_merchant(merchant_id)
  * May be move to Ecto over File system.



