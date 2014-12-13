Rails.application.generators do |app|
  ::Rails::Generators.hidden_namespaces.reject! { |namespace| namespace.start_with?("rspec") }
end
