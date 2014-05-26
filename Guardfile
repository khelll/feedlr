guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/gateway/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/feedlr/#{m[1]}_spec.rb" }
  watch(%r{^lib/gateway/(.+)\.rb$})     { |m| "spec/feedlr/gateway/#{m[1]}_spec.rb" }
  watch('spec/helper.rb')  { "spec" }
end
