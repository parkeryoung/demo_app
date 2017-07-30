json.product do
  json.id @product.id
  json.title @product.title
  json.description @product.description
  json.start_date @product.start_date
  json.end_date @product.end_date
  json.rate_plans @product.rate_plans.active do |plan|
    json.title plan.title
    json.description plan.description
    json.start_date plan.start_date
    json.end_date plan.end_date
    json.recurrence plan.recurrence
    json.price plan.price
  end
end
