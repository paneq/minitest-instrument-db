require 'active_record'
require 'logger'

module Minitest

  module Instrument

    module Db

      class MinitestTestMethod < ActiveRecord::Base
        set_table_name :minitest_test_methods
      end

      def self.try_configuration_at(*params)
        configuration_at(*params)
      rescue
        puts "Instrumenting test methods is disabled due to exception"
      end

      def self.configuration_at(database_yml, options = {})
        options[:project] ||= "Unknown"
        options[:machine] ||= begin
          require 'socket'
          Socket.gethostname
        end
        
        connection = ActiveRecord::Base.connection rescue nil
        ActiveRecord::Base.configurations.merge! YAML::load(  IO.read( database_yml )  )
        ActiveRecord::Base.establish_connection("minitest-instrument-db")

        ActiveRecord::Migrator.migrate(  File.join( File.dirname(__FILE__), 'migrations' )  )

        MinitestTestMethod.establish_connection("minitest-instrument-db")
        
        ActiveSupport::Notifications.subscribe "test.finished" do |name, start, finish, id, payload|
          MinitestTestMethod.create!(
            project: options[:project],
            machine: options[:machine],
            test_id: id,
            klass: payload[:klass],
            method: payload[:test],
            exception: !!payload[:exception],
            execution_time: finish - start
            # created_at !!
          )
        end
      ensure
        if connection
          config = ActiveRecord::Base.connection.instance_variable_get(:@config).stringify_keys
          name, configuration = ActiveRecord::Base.configurations.find{|k,v| v == config}
          ActiveRecord::Base.establish_connection(name)
        end
      end
      
    end

  end

end
