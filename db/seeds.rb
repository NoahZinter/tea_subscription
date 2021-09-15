# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Subscription.destroy_all
SubscriptionTea.destroy_all
Tea.destroy_all

customer = Customer.create!(first_name: 'Noah', last_name: 'Zinter', address: '123 Street Ln. City, ST 12345', email: 'ex@ample.com', google_token: ';ohaset1', google_refresh_token: '123pouiyp9y')
sub_1 = customer.subscriptions.create!(title: "Noah's monthly tea subscription", price: 12.3, status: 2)
sub_2 = customer.subscriptions.create!(price: 2.3)
sub_3 = customer.subscriptions.create!(price:  3.4)
sub_4 = customer.subscriptions.create!(price: 4.5, frequency: 0, status: 1)


tea_1 = Tea.create!(variety: 'Oolong', description: 'Delicious', temperature: 90, brew_time: 2, origin: 'China')
tea_2 = Tea.create!(variety: 'Black', description: 'Bitter', temperature: 90, brew_time: 2, origin: 'India')
tea_3 = Tea.create!(variety: 'Lapsang Souchong', description: 'Smoky', temperature: 90, brew_time: 2, origin: 'China')
tea_4 = Tea.create!(variety: 'Green', description: 'Light', temperature: 90, brew_time: 2, origin: 'Nepal')
tea_5 = Tea.create!(variety: 'Earl Grey', description: 'Invigorating', temperature: 90, brew_time: 2, origin: 'Ghana')
tea_6 = Tea.create!(variety: 'Peppermint', description: 'Minty', temperature: 90, brew_time: 2, origin: 'Morocco')

SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_1.id)
SubscriptionTea.create!(tea_id: tea_2.id, subscription_id: sub_1.id)
SubscriptionTea.create!(tea_id: tea_4.id, subscription_id: sub_1.id)
SubscriptionTea.create!(tea_id: tea_3.id, subscription_id: sub_1.id)

SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_4.id)
SubscriptionTea.create!(tea_id: tea_3.id, subscription_id: sub_4.id)
SubscriptionTea.create!(tea_id: tea_5.id, subscription_id: sub_4.id)
SubscriptionTea.create!(tea_id: tea_6.id, subscription_id: sub_4.id)
SubscriptionTea.create!(tea_id: tea_2.id, subscription_id: sub_4.id)

SubscriptionTea.create!(tea_id: tea_5.id, subscription_id: sub_2.id)
SubscriptionTea.create!(tea_id: tea_4.id, subscription_id: sub_2.id)
SubscriptionTea.create!(tea_id: tea_2.id, subscription_id: sub_2.id)