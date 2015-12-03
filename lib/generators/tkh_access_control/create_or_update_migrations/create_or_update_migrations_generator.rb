require 'rails/generators/migration'

module TkhAccessControl
  module Generators
    class CreateOrUpdateMigrationsGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations and locale files"
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        puts 'creating authentication and authorization migrations'
        migration_template "create_users.rb", "db/migrate/create_users.rb"
        migration_template "create_roles.rb", "db/migrate/create_roles.rb"
        migration_template "create_powers.rb", "db/migrate/create_powers.rb"
        migration_template "create_permissions.rb", "db/migrate/create_permissions.rb"
        migration_template "create_abilities.rb", "db/migrate/create_abilities.rb"
        migration_template "add_stripe_customer_id_to_users.rb", "db/migrate/add_stripe_customer_id_to_users.rb"
        migration_template "add_description_to_roles.rb", "db/migrate/add_description_to_roles.rb"
      end

    end
  end
end
