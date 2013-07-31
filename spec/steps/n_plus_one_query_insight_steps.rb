step "I have an app with an n+1 query" do
  @app = App.make!(user: @user)
  @source = Source.make!(app: @app)
  @transaction = Transaction.make!(:with_zero_runtime, source: @source)
  @n_plus_one_query = NPlusOneQuery.make!(transaction: @transaction)
end

step "I view the source of the n+1 query" do
  visit app_source_path(@source.app, @source)
end

step "I view the transaction of the n+1 query" do
  visit app_transaction_path(@transaction.app, @transaction)
end
