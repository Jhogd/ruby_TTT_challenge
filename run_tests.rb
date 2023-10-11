require 'test/unit'

Dir.glob(File.join(File.dirname(__FILE__), 'spec', '*.rb')).each do |file|
  require_relative file
end

Test::Unit::AutoRunner.run