step "I have an app that sent an email in a request" do
  @app = App.make!(user: @user)
  @source = Source.make!(app: @app)
  @transaction = Transaction.make!(:with_zero_runtime, source: @source)
  MailerEvent.make!(transaction: @transaction)
end

step "I view the the source of the request that sent the email" do
  visit app_source_path(@source.app, @source)
end

step "I view the transaction that sent an email" do
  visit app_transaction_path(@transaction.app, @transaction)
end
