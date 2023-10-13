### Please describe found weak places below.

#### Security issues

1. This is bad: @transaction = Transaction.new(params[:transaction].permit!), permits all params, define which params are allowed. The problem is you can pass to_amount to controller to force a greater amount to be converted to.
2.  In create need to add logic, if (and only if) the amount is > 1000, associate manager. The logic should depend on the transaction amount, and not the params[:type], because that can be spoofed via Postman, etc
3.Transaction model needs validation method for this:
large: $100 - $1000 (only from USD). They require more client personal info: first name and last name.
#### Performance issues

1. @manager = Manager.all.sample loads all managers into memory, then selects one from an array randomly, this is inefficient if there are many manager records
this is more efficient: Manager.order('RANDOM()').limit(1).last
2. Loads all (millions) of transactions into, fixed by pagination
3. ...
#### Code issues

1. What if the transaction is not found? will throw an error, better to use find_by_id and show a message if not found
2.  5 HEX characters produces a maximum of 16 ^ 5 = 1,048,576 variations, which is not enough unique combinations for multiple millions of transactions, should be a value greater than 5, for example 8
3. Unnesessary routes: get 'transactions/new/:type', to: 'transactions#new', as: :new_transaction routes all transactions, even large and XL
so these don't have any effect and can be removed
#### Others

1. ...
2. ...
3. ...
