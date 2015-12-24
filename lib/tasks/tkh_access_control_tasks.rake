namespace :tkh_access_control do
  desc "Create migrations and locale files"
  task :install do
    system 'rails g tkh_access_control:create_or_update_migrations'
    system 'rails g tkh_access_control:create_or_update_locales -f'
  end

  desc "Update files. Skip existing migrations. Force overwrite locales"
  task :update do
    system 'rails g tkh_access_control:create_or_update_migrations -s'
    system 'rails g tkh_access_control:create_or_update_locales -f'
  end

  desc "Upgrading roles and permissions from the tkh_authentication gem. Transfering admins to new system."
  task :upgrade_from_tkh_authentication do
    # create the main role
    admin_role = Role.create name: 'admin', description: 'Can do everything'
    # Give all permissions to the admins
    admin_role.permissions << Permission.find_or_create_by(name: 'write_settings')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_pages')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_comments')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_graphics')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_downloads')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_menus')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_members')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_roles')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_contacts')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_mailings')
    admin_role.permissions << Permission.find_or_create_by(name: 'read_activities')
    admin_role.permissions << Permission.find_or_create_by(name: 'write_activities')
    admin_role.permissions << Permission.find_or_create_by(name: 'read_search_stats')

    ## other roles are created for convenience
    page_editor_role = Role.create name: 'page editor', description: 'Can see and edit pages, graphics, menus, and downloads'
    page_editor_role.permissions << Permission.find_or_create_by(name: 'write_pages')
    page_editor_role.permissions << Permission.find_or_create_by(name: 'write_graphics')
    page_editor_role.permissions << Permission.find_or_create_by(name: 'write_downloads')
    page_editor_role.permissions << Permission.find_or_create_by(name: 'write_menus')

    moderator_role = Role.create name: 'moderator', description: 'Can see, edit, and moderate user comments'
    moderator_role.permissions << Permission.find_or_create_by(name: 'write_comments')

    mailing_list_role = Role.create name: 'mailing list', description: 'Can see and edit users, messages from contact form, and mailings, as well as read user activities'
    mailing_list_role.permissions << Permission.find_or_create_by(name: 'write_members')
    mailing_list_role.permissions << Permission.find_or_create_by(name: 'write_contacts')
    mailing_list_role.permissions << Permission.find_or_create_by(name: 'write_mailings')
    mailing_list_role.permissions << Permission.find_or_create_by(name: 'read_activities')

    statistician_role = Role.create name: 'statistician', description: 'Can read and analyze the site search stats'
    statistician_role.permissions << Permission.find_or_create_by(name: 'read_search_stats')

    User.where(admin: true).each do |user|
      user.roles << admin_role
    end
  end
end
